<script lang="ts">
	import { contract, provider } from '$fc-stores/contract.store';
	import { Card } from '$fc-types';
	import { onMount } from 'svelte';

	let card: Card;
	let selectedCategory = '';
	let cardsByCategory = new Map();

	let showCard = false;

	onMount(async () => {
		const address = await $provider?.getSigner().getAddress();
		console.log(address);
		const myCards = await $contract?.getCardsByOwner(address);
		console.log(myCards);

		for (const dataCard of myCards) {
			const card = new Card(dataCard);

			if (cardsByCategory.get(card.category)) {
				cardsByCategory.set(card.category, {
					cards: [...cardsByCategory.get(card.category).cards, card]
				});
			} else {
				console.log('searching', card.category);
				// const imageResp = await fetch(
				// 	`https://api.unsplash.com/search/photos?page=1&query=${card.category}&per_page=1`,
				// 	{
				// 		method: 'GET',
				// 		headers: {
				// 			Authorization: `Client-ID ${apiToken}`
				// 		}
				// 	}
				// );
				// const imageResult = await imageResp.json();
				cardsByCategory.set(card.category, {
					cards: [card]
					// imageUrl: imageResult.results[0].urls?.regular
				});
			}
		}

		console.log(cardsByCategory);
	});

	async function next() {
		showCard = false;
		// card =
		// 	cardsByCategory[selectedCategory][
		// 		Math.floor(Math.random() * cardsByCategory[selectedCategory].length)
		// 	];
	}

	function reveal() {
		showCard = true;
	}

	function setCategory(category: string) {
		selectedCategory = category;
		next();
	}
</script>

{#if cardsByCategory.size > 0}
	<div class="grid grid-cols-4 gap-4">
		{#each Object.entries(cardsByCategory) as [category, value]}
			<div class="card bg-base-100 shadow-xl image-full">
				<figure><img src={value.imageUrl} alt={category} /></figure>
				<div class="card-body">
					<h2 class="card-title">{category}</h2>
					<div class="card-actions w-full">
						<button class="btn btn-primary" on:click={() => setCategory(category)}
							>{category}</button
						>
					</div>
				</div>
			</div>
		{/each}
	</div>
{:else}
	<div class="card bg-base-100 shadow-xl">
		<div class="card-body">
			<h2 class="card-title">No Cards Found</h2>
			<p>
				There are no cards for this account. Navigate <a href="/add">here</a> to add your first card.
			</p>
		</div>
	</div>
{/if}

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
