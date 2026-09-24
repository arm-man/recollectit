export type AnswerTokenErrorReporter = (message: string) => void;

type AnswerTokenDefinition = {
  substitutions: readonly string[];
};

const ANSWER_TOKEN_DEFINITIONS: ReadonlyMap<string, AnswerTokenDefinition> =
  new Map([
    [
      "3sg",
      {
        substitutions: ["it", "she", "he"],
      },
    ],
  ]);

const ANSWER_TOKEN_PATTERN = /\{([^{}]*)\}/gu;

type ParsedAnswerToken = {
  preferredValue: string;
  substitutions: readonly string[];
};

function parseAnswerToken(
  tokenText: string,
  tokenBody: string,
  reportError?: AnswerTokenErrorReporter,
): ParsedAnswerToken | null {
  const separatorIndex = tokenBody.indexOf("-");

  if (separatorIndex <= 0 || separatorIndex === tokenBody.length - 1) {
    reportError?.(`Malformed Answer token "${tokenText}".`);
    return null;
  }

  const tokenType = tokenBody.slice(0, separatorIndex);
  const preferredValue = tokenBody.slice(separatorIndex + 1);
  const definition = ANSWER_TOKEN_DEFINITIONS.get(tokenType);

  if (!definition) {
    reportError?.(
      `Unknown Answer token type "${tokenType}" in "${tokenText}".`,
    );
    return null;
  }

  if (!definition.substitutions.includes(preferredValue)) {
    reportError?.(
      `Unsupported preferred value "${preferredValue}" in Answer token "${tokenText}".`,
    );
    return null;
  }

  return {
    preferredValue,
    substitutions: definition.substitutions,
  };
}

export function expandAnswerTokens(
  answerText: string,
  reportError?: AnswerTokenErrorReporter,
): string[] {
  const expandedAnswers = [""];
  let previousMatchEnd = 0;

  for (const match of answerText.matchAll(ANSWER_TOKEN_PATTERN)) {
    const matchIndex = match.index;
    const tokenText = match[0];
    const parsedToken = parseAnswerToken(tokenText, match[1], reportError);
    const prefix = answerText.slice(previousMatchEnd, matchIndex);
    const substitutions = parsedToken?.substitutions ?? [tokenText];
    const answersBeforeToken = [...expandedAnswers];

    expandedAnswers.length = 0;

    for (const answerBeforeToken of answersBeforeToken) {
      for (const substitution of substitutions) {
        expandedAnswers.push(answerBeforeToken + prefix + substitution);
      }
    }

    previousMatchEnd = matchIndex + tokenText.length;
  }

  const suffix = answerText.slice(previousMatchEnd);
  return expandedAnswers.map((expandedAnswer) => expandedAnswer + suffix);
}

export function formatAnswerForDisplay(
  answerText: string,
  reportError?: AnswerTokenErrorReporter,
): string {
  return answerText.replace(
    ANSWER_TOKEN_PATTERN,
    (tokenText: string, tokenBody: string) =>
      parseAnswerToken(tokenText, tokenBody, reportError)?.preferredValue ??
      tokenText,
  );
}
