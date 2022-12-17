# Web3 Flashcard App

## Description

Learn new things while utilizing the power of Web3

## Startup

From /app

`pnpm dev`

To run local node

`anvil`

Deploy FlashCard contract

`forge create FlashCard --private-key [private key from local node]`

Paste contract address into +layout.svelte

`defaultEvmStores.attachContract(
  'flashcard',
  '0x5FbDB2315678afecb367f032d93F642f64180aa3',
  JSON.stringify(flashCard)
);`

Get ABI of contract

`forge inspect src/FlashCard.sol:FlashCard abi --extra-output-files abi > ../app/src/abis/FlashCard.json`
