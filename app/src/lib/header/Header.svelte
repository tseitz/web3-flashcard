<script lang="ts">
	import { onMount } from 'svelte';
	import { ethers } from 'ethers';

	import ConnectButton from './ConnectButton.svelte';
	import { provider } from '$fc-stores/contract.store';

	let pending = false;

	onMount(async () => {
		if (window.ethereum) {
			console.log('window.ethereum found. connecting...');
			await connect();
		}
	});

	const connect = async () => {
		pending = true;
		try {
			provider.set(new ethers.providers.Web3Provider(window.ethereum));
			await $provider?.send('eth_requestAccounts', []);

			pending = false;
		} catch (e) {
			console.log(e);
			pending = false;
		}
	};

	const disconnect = async () => {
		console.log('disconnecting');
		provider.set(null);
		pending = false;
	};
</script>

<div class="navbar bg-base-100">
	<div class="flex-1 gap-2">
		<a class="btn btn-ghost normal-case text-xl" href="/">Unlimited Knowledge</a>
		{#await $provider?.getNetwork() then value}
			{#if value?.name}<span
					>powered by {value?.name === 'unknown' ? 'localhost' : value?.name}</span
				>
			{:else}<span>loading provider...</span>{/if}
		{:catch error}
			<span>something went wrong {error}</span>
		{/await}
	</div>
	<div class="flex-none gap-2">
		<div class="flex-none">
			{#if pending}
				<ConnectButton text="Connecting..." />
			{:else if $provider?.getSigner()}
				<ConnectButton text="Disconnect" action={disconnect} btnStyle="pr-1">
					<span class="avatar">
						<div class="w-10 rounded-full">
							<img src="https://placeimg.com/80/80/people" alt="profile" />
						</div>
					</span>
				</ConnectButton>
			{:else}
				<ConnectButton text="Connect" action={connect} />
			{/if}
		</div>
	</div>
</div>
