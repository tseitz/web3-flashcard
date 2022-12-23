<script lang="ts">
	import type { Card } from 'src/types';
	import { onMount } from 'svelte';
	import { contracts, signerAddress } from 'svelte-ethers-store';

	let cards: Card[];
	let card: Card;
	// can't use maps because they aren't reactive
	let cardsByCategory: { [index: string]: Card[] } = {};
	let selectedCategory = '';
	const apiToken = 'c05b5a334ca3ca76bfbf7f5e8896357ca6b3f0d8';

	let showCard = false;

	$: flashCard = $contracts.flashcard;

	onMount(async () => {
		cards = await flashCard.getCardsByOwner($signerAddress);

		cards.forEach((card) => {
			cardsByCategory[card.category] = [...(cardsByCategory[card.category] || []), card];
		});
	});

	function next() {
		showCard = false;
		card =
			cardsByCategory[selectedCategory][
				Math.floor(Math.random() * cardsByCategory[selectedCategory].length)
			];
	}

	function reveal() {
		showCard = true;
	}

	function setCategory(category: string) {
		selectedCategory = category;
		next();
	}

	async function test(category: string) {
		const test = await fetch('https://api.replicate.com/v1/predictions', {
			method: 'POST',
			headers: {
				Authorization: `Token ${apiToken}`,
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				version: '6359a0cab3ca6e4d3320c33d79096161208e9024d174b2311e5a21b6c7e1131c',
				input: {
					prompt: category
				}
			})
		});
		console.log(test);
	}
</script>

<div class="grid grid-cols-4 gap-4">
	{#each Object.entries(cardsByCategory) as [category]}
		<!-- <div>
      <button class="btn btn-primary" on:click={() => setCategory(category)}>{category}</button>
    </div> -->
		<div class="card bg-base-100 shadow-xl image-full">
			<figure><img src="https://placeimg.com/400/225/arch" alt={category} /></figure>
			<div class="card-body">
				<h2 class="card-title">{category}</h2>
				<div class="card-actions w-full">
					<button class="btn btn-primary" on:click={() => test(category)}>{category}</button>
				</div>
			</div>
		</div>
	{/each}
</div>

{#if card}
	<div class="card w-96 bg-base-100 shadow-xl">
		<div class="card-body">
			<h2 class="card-title">{card.prompt}</h2>
			<p class={showCard ? 'reveal' : 'hide'}>{card.answer}</p>
			<div class="card-actions justify-end">
				<button class="btn btn-primary" on:click={() => reveal()}>Reveal</button>
				<button class="btn btn-primary" on:click={() => next()}>Next</button>
			</div>
		</div>
	</div>
{/if}

<style>
	.reveal {
		visibility: visible;
	}

	.hide {
		visibility: hidden;
	}
</style>
