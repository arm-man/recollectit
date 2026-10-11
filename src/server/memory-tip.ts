export function getMemoryTipForFeedback(
  tipText: string | null,
  isCorrect: boolean,
): string | null {
  if (isCorrect || tipText === null || tipText.trim() === "") {
    return null;
  }

  return tipText;
}
