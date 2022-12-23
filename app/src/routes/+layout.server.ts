import { ethers } from 'ethers';
import type { LayoutServerLoad } from './$types';
import flashCard from '../abis/FlashCard.json';

export const load = (() => {
	const provider = new ethers.providers.JsonRpcProvider('http://localhost:8545');
	const contract = new ethers.Contract(
		'0x5FbDB2315678afecb367f032d93F642f64180aa3',
		JSON.stringify(flashCard),
		provider
	);

	contract.getCardsByOwner('0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266').then(function (result) {
		console.log(result);
	});

	return {};
}) satisfies LayoutServerLoad;
