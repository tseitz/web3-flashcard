// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract FlashCard {
    string public prompt;
    string public answer;

    function saveCard(string calldata inPrompt, string calldata inAnswer)
        public
    {
        prompt = inPrompt;
        answer = inAnswer;
    }
}
