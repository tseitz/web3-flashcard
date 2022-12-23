import {
	writable,
	readable,
	derived,
	type Readable,
	type Subscriber,
	type Writable
} from 'svelte/store';
import { ethers } from 'ethers';
import flashCard from '../abis/FlashCard.json';

// export const provider: Readable<ethers.providers.JsonRpcProvider | null> = readable(
// 	null,
// 	(set: Subscriber<ethers.providers.JsonRpcProvider | null>) => {
// 		set(new ethers.providers.JsonRpcProvider('http://localhost:8545'));
// 		return () => null;
// 	}
// );

export const provider: Writable<ethers.providers.JsonRpcProvider> = writable();

export const contract = derived(provider, (values, set: Subscriber<ethers.Contract | null>) => {
	if (values !== null) {
		console.log('setting contract');
		set(
			new ethers.Contract(
				'0x5FbDB2315678afecb367f032d93F642f64180aa3',
				JSON.stringify(flashCard),
				values
			)
		);
	}
	return () => null;
});
