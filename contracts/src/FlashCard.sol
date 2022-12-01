// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract FlashCard {
    event FlashCardCreated(uint256 id, string prompt, string answer);

    mapping(uint256 => address) public cardToOwner;
    mapping(address => uint256) ownerCardCount;

    struct Card {
        string prompt;
        string answer;
    }

    Card[] public cards;

    function saveCard(string memory _prompt, string memory _answer) public {
        cards.push(Card(_prompt, _answer));
        uint256 id = cards.length - 1;
        cardToOwner[id] = msg.sender;
        ownerCardCount[msg.sender]++;
        emit FlashCardCreated(id, _prompt, _answer);
    }

    function getCardsByOwner(address _owner)
        external
        view
        returns (uint256[] memory)
    {
        uint256[] memory result = new uint256[](ownerCardCount[_owner]);
        uint256 counter = 0;
        for (uint256 i = 0; i < cards.length; i++) {
            if (cardToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function getCardById(uint256 _id)
        external
        view
        returns (string memory, string memory)
    {
        return (cards[_id].prompt, cards[_id].answer);
    }
}
