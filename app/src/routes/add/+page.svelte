<script lang="ts">
	let prompt: string;
  let answer: string;

  function saveCard() {
    console.log(prompt, answer)
  }
</script>

<div class="form-control">
  <label class="label" for="prompt">
    <span class="label-text">Question/Prompt</span>
  </label> 
  <textarea id="prompt" class="textarea textarea-bordered h-24" placeholder="I want to learn..." bind:value={prompt}></textarea>
</div>

<div class="form-control">
  <label class="label" for="answer">
    <span class="label-text">Answer</span>
  </label> 
  <textarea id="answer" class="textarea textarea-bordered h-24" placeholder="So much knowledge..." bind:value={answer}></textarea>
</div>

<button class="btn btn-primary" on:click={() => saveCard()}>Save</button>