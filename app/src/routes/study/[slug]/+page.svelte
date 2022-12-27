<script lang="ts">
	import type { Card } from '$fc-types';
	import type { PageData } from './$types';

	export let data: PageData;

	let card: Card;
	let selectedCategory = '';

	let showCard = false;

	function next() {
		showCard = false;
		card =
			data.cards[selectedCategory][Math.floor(Math.random() * data.cards[selectedCategory].length)];
		console.log(card);
	}

	function reveal() {
		showCard = true;
	}

	function setCategory(category: string) {
		selectedCategory = category;
		next();
	}

	// async function test(category: string) {
	// 	const test = await fetch('https://api.replicate.com/v1/predictions', {
	// 		method: 'POST',
	// 		headers: {
	// 			Authorization: `Token ${apiToken}`,
	// 			'Content-Type': 'application/json'
	// 		},
	// 		body: JSON.stringify({
	// 			version: '6359a0cab3ca6e4d3320c33d79096161208e9024d174b2311e5a21b6c7e1131c',
	// 			input: {
	// 				prompt: category
	// 			}
	// 		})
	// 	});
	// 	console.log(test);
	// }
</script>

<div class="grid grid-cols-4 gap-4">
	{#each Object.entries(data.cards) as [category]}
		<div class="card bg-base-100 shadow-xl image-full">
			<figure><img src="https://placeimg.com/400/225/arch" alt={category} /></figure>
			<div class="card-body">
				<h2 class="card-title">{category}</h2>
				<div class="card-actions w-full">
					<button class="btn btn-primary" on:click={() => setCategory(category)}>{category}</button>
					<!-- <button class="btn btn-primary" on:click={() => test(category)}>{category}</button> -->
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
