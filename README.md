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

To Mumbai Testnet
`forge create FlashCard --rpc-url $ALCHEMY_MUMBAI_URL --private-key $ETH_WALLET_PRIVATE_KEY`

Paste contract address into +layout.svelte

`defaultEvmStores.attachContract(
  'flashcard',
  '0x5FbDB2315678afecb367f032d93F642f64180aa3',
  JSON.stringify(flashCard)
);`

Get ABI of contract

`forge inspect src/FlashCard.sol:FlashCard abi --extra-output-files abi > ../app/src/abis/FlashCard.json`

## Random Details

All chain data is read from the back-end since it uses the default provider. Front-end handles the wallet signer and interacts with the contract via the signer.

I try to do as much server rendering as possible, data loading etc. Updates are handled on front-end.
