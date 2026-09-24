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

test("applies distance thresholds at Answer length boundaries", () => {
  assert.equal(isGuessCorrect("cats", "catx"), false);
  assert.equal(isGuessCorrect("house", "mouse"), true);
  assert.equal(isGuessCorrect("abcdefghi", "xbcdefghx"), false);
  assert.equal(isGuessCorrect("abcdefghij", "xbcdefghix"), true);
});

test("preserves single-Answer behavior when no Alternate Answer exists", () => {
  assert.equal(isGuessCorrect("Londno", "London"), true);
  assert.equal(isGuessCorrect("Londxx", "London"), false);
});

test("accepts every third-person-singular substitution in the Primary Answer", () => {
  for (const guess of ["it is raining", "she is raining", "he is raining"]) {
    assert.equal(isGuessCorrect(guess, "{3sg-it} is raining"), true);
  }
});

test("accepts every substitution regardless of the preferred display value", () => {
  for (const preferredValue of ["she", "he"]) {
    for (const guess of ["it is happy", "she is happy", "he is happy"]) {
      assert.equal(
        isGuessCorrect(guess, `{3sg-${preferredValue}} is happy`),
        true,
      );
    }
  }
});

test("rejects a substitution not supported by the token", () => {
  assert.equal(isGuessCorrect("they are raining", "{3sg-it} is raining"), false);
});

test("supports a token in the Alternate Answer", () => {
  assert.equal(
    isGuessCorrect(
      "HE HAS ARRIVED!!!",
      "The train arrived",
      "{3sg-she} has arrived",
    ),
    true,
  );
});

test("preserves normalization and fuzzy matching for tokenized Answers", () => {
  assert.equal(
    isGuessCorrect("  SHE   IS DEJA HERE!!! ", "{3sg-it} is déjà here"),
    true,
  );
  assert.equal(
    isGuessCorrect("he is alreayd waiting", "{3sg-she} is already waiting"),
    true,
  );
});
