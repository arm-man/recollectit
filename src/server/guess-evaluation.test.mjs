import assert from "node:assert/strict";
import test from "node:test";

import { isGuessCorrect } from "./guess-evaluation.ts";

test("accepts a Guess matching the Primary Answer", () => {
  assert.equal(isGuessCorrect("Paris", "Paris", "City of Light"), true);
});

test("accepts a Guess matching the Alternate Answer", () => {
  assert.equal(isGuessCorrect("United States", "USA", "United States"), true);
});

test("rejects a Guess matching neither Answer", () => {
  assert.equal(isGuessCorrect("Canada", "USA", "United States"), false);
});

test("rejects an empty normalized Guess when an Alternate Answer exists", () => {
  assert.equal(isGuessCorrect(" -- ", "USA", "United States"), false);
});

test("uses each Answer's length to determine its allowed distance", () => {
  // The four-character Primary Answer allows no edits, while the longer
  // Alternate Answer allows one. This Guess is accepted only by the latter.
  assert.equal(isGuessCorrect("colourr", "huex", "colours"), true);
});

test("preserves single-Answer behavior when no Alternate Answer exists", () => {
  assert.equal(isGuessCorrect("Londno", "London"), true);
  assert.equal(isGuessCorrect("Londxx", "London"), false);
});
