export type PickedCard = Pick<Card, 'id' | 'category' | 'prompt' | 'answer'>;

export class Card {
	id: number;
	category: string;
	prompt: string;
	answer: string;

	constructor(cardData: PickedCard) {
		this.id = parseInt(cardData.id.toString(), 10);
		this.category = cardData.category;
		this.prompt = cardData.prompt;
		this.answer = cardData.answer;
	}
}
