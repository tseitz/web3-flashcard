// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract FlashCard {
    /// @notice Dispatched when Flash Card is created
    event FlashCardCreated(
        uint256 id,
        string category,
        string prompt,
        string answer
    );

    /// @notice currently not in use, will analyze how I want to use this
    mapping(uint256 => address) public cardToOwner;
    mapping(address => uint256) ownerCardCount;

    /// @notice struct for flash card
    struct Card {
        uint256 id;
        string category;
        string prompt;
        string answer;
    }

    /// @notice mapping of address to array of cards
    mapping(address => Card[]) public cards;

    /// @notice function to create a flash card. Emits FlashCardCreated event
    /// @param _category string of category
    /// @param _prompt string of prompt
    /// @param _answer string of answer
    /// @dev generates id by getting length of array of cards for msg.sender and pushes to senders cards
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

    // function editCard(
    //     uint256 _id,
    //     string memory _category,
    //     string memory _prompt,
    //     string memory _answer
    // ) public {
    //     uint256 id = cards[msg.sender].length;
    //     Card memory myCard = Card({
    //         id: id,
    //         category: _category,
    //         prompt: _prompt,
    //         answer: _answer
    //     });
    //     cards[msg.sender].push(myCard);

    //     emit FlashCardCreated(id, _category, _prompt, _answer);
    // }

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
