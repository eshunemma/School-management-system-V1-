import { assert } from "chai";
import {
    toCapitalizeEachWord,
    toSentenceCase,
} from "../src/helpers/text-formatter.js";

describe("toSentenceCase", () => {
    it("should capitalize the first letter and convert the rest to lowercase", () => {
        const input = "hello, world";
        const expectedOutput = "Hello, world";
        const result = toSentenceCase(input);
        assert.strictEqual(result, expectedOutput);
    });

    it("should return an empty string if the input is empty", () => {
        const input = "";
        const expectedOutput = "";
        const result = toSentenceCase(input);
        assert.strictEqual(result, expectedOutput);
    });

    it("should capitalize a single character", () => {
        const input = "a";
        const expectedOutput = "A";
        const result = toSentenceCase(input);
        assert.strictEqual(result, expectedOutput);
    });

    it("should return null if the input is null", () => {
        const input = null;
        const expectedOutput = null;
        const result = toSentenceCase(input);
        assert.strictEqual(result, expectedOutput);
    });
});

describe("toCapitalizeEachWord", () => {
    it("should capitalize the first letter of each word", () => {
        const input = "hello world";
        const expectedOutput = "Hello World";
        const result = toCapitalizeEachWord(input);
        assert.strictEqual(result, expectedOutput);
    });

    it("should handle a single-word input", () => {
        const input = "hello";
        const expectedOutput = "Hello";
        const result = toCapitalizeEachWord(input);
        assert.strictEqual(result, expectedOutput);
    });

    it("should handle an empty string input", () => {
        const input = "";
        const expectedOutput = "";
        const result = toCapitalizeEachWord(input);
        assert.strictEqual(result, expectedOutput);
    });

    it("should handle null input", () => {
        const input = null;
        const expectedOutput = null;
        const result = toCapitalizeEachWord(input);
        assert.strictEqual(result, expectedOutput);
    });
});
