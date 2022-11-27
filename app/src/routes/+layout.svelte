<script type="ts">
  import "../app.css";
  import { goto } from "$app/navigation";
  
  import { onMount } from 'svelte';
  import type { LayoutData } from './$types';

  import { defaultEvmStores, provider, signer, contracts } from 'svelte-ethers-store';
  // import Web3Modal from 'web3modal';

  import Header from '$lib/header/Header.svelte';
  import '../app.css';

  export let data: LayoutData;
  
  function navigate(route: string) {
    goto(route);
  }

	let pending = true;
	// let web3Modal: Web3Modal;

	onMount(async () => {
		// web3Modal = new Web3Modal({
		// 	network: 'goerli', // optional
		// 	cacheProvider: true, // optional
		// 	providerOptions: {} // required
		// });

		if (window.ethereum) {
			console.log('window.ethereum found. connecting...', window.ethereum);
			await connect();
		}
	});

	const connect = async () => {
		pending = true;
		try {
			// await defaultEvmStores.setProvider('http://localhost:8545');
			await defaultEvmStores.setProvider();
			// console.log($chainId);

			const { name, chainId } = await $provider.getNetwork();
			console.log('$chainId', chainId);
			console.log('$name', name);

			const balance = await $signer.getBalance();
			console.log('balance', balance.toBigInt());

			defaultEvmStores.attachContract(
				'betting',
				'0x9fe46736679d2d9a65f0992f2272de9f3c7fa6e0',
				'[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[],"name":"Unauthorized","type":"error"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"better","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"total","type":"uint256"}],"name":"BetMade","type":"event"},{"inputs":[{"internalType":"address","name":"pool","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"bet","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"end","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"pool","type":"address"}],"name":"getBetAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"}]'
			);

			pending = false;
		} catch (e) {
			console.log(e);
			pending = false;
		}
	};
</script>

<Header {pending} {connect} />

<slot />

<div class="btm-nav">
  <button class="text-primary active" on:click={() => navigate('/')}>
      <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
      </svg>
  </button>
  <button class="text-primary" on:click={() => navigate('/add')}>
    <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
      <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
    </svg>
  </button>
  <button class="text-primary" on:click={() => navigate('/study')}>
      <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path d="M6.79 5.093A.5.5 0 0 0 6 5.5v5a.5.5 0 0 0 .79.407l3.5-2.5a.5.5 0 0 0 0-.814l-3.5-2.5z"/>
        <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4zm15 0a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4z"/>
      </svg>
  </button>
</div>