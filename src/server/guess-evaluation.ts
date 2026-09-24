import {
  expandAnswerTokens,
  type AnswerTokenErrorReporter,
} from "./answer-tokens.ts";

const SPECIAL_LETTER_REPLACEMENTS: Readonly<Record<string, string>> = {
  ø: "o",
  Ø: "o",
  ł: "l",
  Ł: "l",
  ß: "ss",
  ẞ: "ss",
  æ: "ae",
  Æ: "ae",
  œ: "oe",
  Œ: "oe",
};

export function normalizeGuessValue(value: string): string {
  const replacedValue = Array.from(
    value,
    (character) => SPECIAL_LETTER_REPLACEMENTS[character] ?? character,
  ).join("");

  return replacedValue
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\p{M}\p{White_Space}\p{P}\p{S}]/gu, "");
}

export function getDamerauLevenshteinDistance(
  sourceValue: string,
  targetValue: string,
): number {
  const source = Array.from(sourceValue);
  const target = Array.from(targetValue);
  const maximumDistance = source.length + target.length;
  const distances = Array.from({ length: source.length + 2 }, () =>
    Array<number>(target.length + 2).fill(0),
  );
  const lastRowByCharacter = new Map<string, number>();

  distances[0][0] = maximumDistance;

  for (let sourceIndex = 0; sourceIndex <= source.length; sourceIndex += 1) {
    distances[sourceIndex + 1][0] = maximumDistance;
    distances[sourceIndex + 1][1] = sourceIndex;
  }

  for (let targetIndex = 0; targetIndex <= target.length; targetIndex += 1) {
    distances[0][targetIndex + 1] = maximumDistance;
    distances[1][targetIndex + 1] = targetIndex;
  }

  // Tracking the last row and column where characters matched implements the
  // unrestricted Damerau-Levenshtein transposition rule, not just adjacent
  // transpositions that cannot overlap.
  for (let sourceIndex = 1; sourceIndex <= source.length; sourceIndex += 1) {
    let lastMatchingColumn = 0;

    for (let targetIndex = 1; targetIndex <= target.length; targetIndex += 1) {
      const lastMatchingRow =
        lastRowByCharacter.get(target[targetIndex - 1]) ?? 0;
      const previousMatchingColumn = lastMatchingColumn;
      const isMatch = source[sourceIndex - 1] === target[targetIndex - 1];

      if (isMatch) {
        lastMatchingColumn = targetIndex;
      }

      distances[sourceIndex + 1][targetIndex + 1] = Math.min(
        distances[sourceIndex][targetIndex] + (isMatch ? 0 : 1),
        distances[sourceIndex + 1][targetIndex] + 1,
        distances[sourceIndex][targetIndex + 1] + 1,
        distances[lastMatchingRow][previousMatchingColumn] +
          (sourceIndex - lastMatchingRow - 1) +
          1 +
          (targetIndex - previousMatchingColumn - 1),
      );
    }

    lastRowByCharacter.set(source[sourceIndex - 1], sourceIndex);
  }

  return distances[source.length + 1][target.length + 1];
}

export function isGuessCorrect(
  guess: string,
  primaryAnswer: string,
  alternateAnswer: string | null = null,
  reportTokenError?: AnswerTokenErrorReporter,
): boolean {
  const normalizedGuess = normalizeGuessValue(guess);

  if (normalizedGuess.length === 0) {
    return false;
  }

  const answers =
    alternateAnswer === null
      ? [primaryAnswer]
      : [primaryAnswer, alternateAnswer];
  const expandedAnswers = answers.flatMap((answer) =>
    expandAnswerTokens(answer, reportTokenError),
  );

  return expandedAnswers.some((answer) => {
    const normalizedAnswer = normalizeGuessValue(answer);
    const answerLength = Array.from(normalizedAnswer).length;
    const maximumDistance = answerLength <= 4 ? 0 : answerLength <= 9 ? 1 : 2;

    return (
      getDamerauLevenshteinDistance(normalizedGuess, normalizedAnswer) <=
      maximumDistance
    );
  });
}
