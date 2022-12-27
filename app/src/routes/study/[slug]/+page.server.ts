import { ethers } from 'ethers';
import type { PageServerLoad } from './$types';
import flashCard from '$fc-abis/FlashCard.json';
import { Card, type PickedCard } from '$fc-types';

interface CardsByCategory {
	[index: string]: Card[];
}

export const load = (async ({ params }) => {
	const provider = new ethers.providers.JsonRpcProvider('http://localhost:8545');
	const contract = new ethers.Contract(
		'0x5FbDB2315678afecb367f032d93F642f64180aa3',
		JSON.stringify(flashCard),
		provider
	);

	const myCards = await contract.getCardsByOwner(params.slug);

	const cardsByCategory: CardsByCategory = myCards.reduce(
		(prev: Partial<CardsByCategory>, dataCard: PickedCard) => {
			const card = new Card(dataCard);
			prev[card.category] = [...(prev[card.category] || []), card];
			return prev;
		},
		{} as Partial<CardsByCategory>
	);

	return {
		cards: JSON.parse(JSON.stringify(cardsByCategory))
	};
}) satisfies PageServerLoad;
