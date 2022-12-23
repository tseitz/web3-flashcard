import type { Actions } from './$types';
import { ethers } from 'ethers';
import flashCard from '../../abis/FlashCard.json';

export const actions = {
	default: async ({ request }) => {
		const data = await request.formData();
		const provider = new ethers.providers.JsonRpcProvider('http://localhost:8545');
		const contract = new ethers.Contract(
			'0x5FbDB2315678afecb367f032d93F642f64180aa3',
			JSON.stringify(flashCard),
			provider
		);
		console.log(data);

		const result = contract.saveCard(data.get('category'), data.get('prompt'), data.get('answer'));
		console.log(result);
	}
} satisfies Actions;
