import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import test from "node:test";

import { getMemoryTipForFeedback } from "./memory-tip.ts";

test("returns a nonempty Memory Tip for feedback", () => {
  assert.equal(
    getMemoryTipForFeedback("Connect the idea to something familiar."),
    "Connect the idea to something familiar.",
  );
});

test("returns no Memory Tip when the value is NULL", () => {
  assert.equal(getMemoryTipForFeedback(null), null);
});

test("treats a whitespace-only Memory Tip as absent", () => {
  assert.equal(getMemoryTipForFeedback(" \r\n\t "), null);
});

test("preserves multiline and long Memory Tip text for display", () => {
  const tip = `First line\n${"unbroken".repeat(30)}`;

  assert.equal(getMemoryTipForFeedback(tip), tip);

  const stylesheet = readFileSync(
    new URL("../app/sessions/[sessionId]/page.module.css", import.meta.url),
    "utf8",
  );
  const memoryTipTextRule = stylesheet.match(/\.memoryTipText\s*\{[^}]+\}/)?.[0];

  assert.ok(memoryTipTextRule);
  assert.match(memoryTipTextRule, /overflow-wrap:\s*anywhere/);
  assert.match(memoryTipTextRule, /white-space:\s*pre-wrap/);
});
