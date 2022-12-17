<script lang="ts">
	import { onMount } from 'svelte';
  import { contracts, signerAddress } from 'svelte-ethers-store';

  let cards: any[];
  let card: any;
  let showCard = false;

  $: flashCard = $contracts.flashcard;

  onMount(async () => {
		cards = await flashCard.getCardsByOwner($signerAddress);
    next()
	});

  async function getCardByCategory(category: string) {
    cards = await flashCard.getCardsByCategory($signerAddress);
    next();
  }

  function next() {
    showCard = false;
    card = cards[Math.floor(Math.random() * cards.length)];
  }

  function reveal() {
    showCard = true;
  }
</script>

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

<button class="btn btn-primary" on:click={() => getCardByCategory('subwoofer')}>Category</button>

<style>
  .reveal {
    visibility: visible;
  }

  .hide {
    visibility: hidden;
  }
</style>