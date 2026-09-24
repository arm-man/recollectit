import assert from "node:assert/strict";
import test from "node:test";

import {
  expandAnswerTokens,
  formatAnswerForDisplay,
} from "./answer-tokens.ts";

test("expands each supported third-person-singular preferred value", () => {
  for (const preferredValue of ["it", "she", "he"]) {
    assert.deepEqual(expandAnswerTokens(`{3sg-${preferredValue}} is ready`), [
      "it is ready",
      "she is ready",
      "he is ready",
    ]);
  }
});

test("formats each third-person-singular token with its preferred value", () => {
  assert.equal(formatAnswerForDisplay("{3sg-it} is raining"), "it is raining");
  assert.equal(
    formatAnswerForDisplay("{3sg-she} has already left"),
    "she has already left",
  );
  assert.equal(
    formatAnswerForDisplay("{3sg-he} wants to go"),
    "he wants to go",
  );
});

test("expands multiple tokens throughout an Answer", () => {
  assert.deepEqual(
    expandAnswerTokens("Yesterday, {3sg-it} said {3sg-she} was ready."),
    [
      "Yesterday, it said it was ready.",
      "Yesterday, it said she was ready.",
      "Yesterday, it said he was ready.",
      "Yesterday, she said it was ready.",
      "Yesterday, she said she was ready.",
      "Yesterday, she said he was ready.",
      "Yesterday, he said it was ready.",
      "Yesterday, he said she was ready.",
      "Yesterday, he said he was ready.",
    ],
  );
});

test("leaves unknown and malformed tokens unchanged and reports errors", () => {
  const errors = [];
  const reportError = (message) => errors.push(message);

  assert.deepEqual(expandAnswerTokens("{plural-they} arrived", reportError), [
    "{plural-they} arrived",
  ]);
  assert.equal(
    formatAnswerForDisplay("{3sg-them} arrived", reportError),
    "{3sg-them} arrived",
  );
  assert.equal(
    formatAnswerForDisplay("{3sg} arrived", reportError),
    "{3sg} arrived",
  );
  assert.equal(errors.length, 3);
  assert.match(errors[0], /Unknown Answer token type/);
  assert.match(errors[1], /Unsupported preferred value/);
  assert.match(errors[2], /Malformed Answer token/);
});

test("preserves Answers without tokens", () => {
  assert.deepEqual(expandAnswerTokens("São Paulo"), ["São Paulo"]);
  assert.equal(formatAnswerForDisplay("São Paulo"), "São Paulo");
});
