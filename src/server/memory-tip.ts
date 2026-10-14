export function getMemoryTipForFeedback(tipText: string | null): string | null {
  if (tipText === null || tipText.trim() === "") {
    return null;
  }

  return tipText;
}
