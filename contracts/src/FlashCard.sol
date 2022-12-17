// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract FlashCard {
    event FlashCardCreated(
        uint256 id,
        string category,
        string prompt,
        string answer
    );

    mapping(uint256 => address) public cardToOwner;
    mapping(address => uint256) ownerCardCount;

    struct Card {
        uint256 id;
        string category;
        string prompt;
        string answer;
    }

    mapping(address => Card[]) public cards;

    function saveCard(
        string memory _category,
        string memory _prompt,
        string memory _answer
    ) public {
        uint256 id = cards[msg.sender].length;
        Card memory myCard = Card({
            id: id,
            category: _category,
            prompt: _prompt,
            answer: _answer
        });
        cards[msg.sender].push(myCard);

        emit FlashCardCreated(id, _category, _prompt, _answer);
    }

    function getCardsByOwner(address _owner)
        external
        view
        returns (Card[] memory)
    {
        return cards[_owner];
    }

    function getCardsByCategory(address _owner, string memory _category)
        external
        view
        returns (Card[] memory)
    {
        Card[] memory myCards = cards[_owner];
        Card[] memory output = new Card[](myCards.length);
        uint256 count = 0;
        for (uint256 i = 0; i < myCards.length; i++) {
            if (
                keccak256(abi.encodePacked((myCards[i].category))) ==
                keccak256(abi.encodePacked((_category)))
            ) {
                output[count] = myCards[i];
                count++;
            }
        }
        return output;
    }
}
