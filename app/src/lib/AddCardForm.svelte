<script lang="ts">
	import type { Card } from '$fc-root/types';
	import { contract } from '$fc-stores/contract.store';
	import { onMount } from 'svelte';

	export let card: Card | undefined = undefined;
	export let back: () => void = () => {};

	let category = card?.category || '';
	let prompt = card?.prompt || '';
	let answer = card?.answer || '';

	async function saveCard() {
		const data = new FormData(this);

		const result = await $contract?.saveCard(category, prompt, answer);

		if (result.confirmations > 0) {
			this.reset();
		}
	}
</script>

<form method="POST" on:submit|preventDefault={saveCard}>
	<div class="form-control">
		<label class="label" for="category">
			<span class="label-text">Category</span>
		</label>
		<input
			name="category"
			id="category"
			type="text"
			placeholder="Category..."
			value={category}
			class="input input-bordered input-primary w-full max-w-xs"
		/>
	</div>

	<div class="form-control">
		<label class="label" for="prompt">
			<span class="label-text">Question/Prompt</span>
		</label>
		<textarea
			name="prompt"
			id="prompt"
			placeholder="I want to learn..."
			value={prompt}
			class="textarea textarea-bordered textarea-primary h-24"
		/>
	</div>

	<div class="form-control">
		<label class="label" for="answer">
			<span class="label-text">Answer</span>
		</label>
		<textarea
			name="answer"
			id="answer"
			placeholder="So much knowledge..."
			value={answer}
			class="textarea textarea-bordered textarea-primary h-24"
		/>
	</div>

	<div class="py-4">
		<button class="btn btn-primary">Save</button>

		<button class="btn btn-primary" on:click|preventDefault={() => back()}>Back</button>

		<!-- <button class="btn btn-secondary" on:click={() => getCardsByOwner()}>Get My Cards</button> -->

		<!-- <button class="btn btn-success" on:click={() => getCardById()}>Get First Card</button>
  
    <button class="btn btn-success" on:click={() => getCards()}>Get All Cards</button> -->
	</div>
</form>
