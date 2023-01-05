import { writable, derived, type Subscriber, type Writable } from 'svelte/store';
import { ethers } from 'ethers';
import flashCard from '$fc-abis/FlashCard.json';

// export const provider: Readable<ethers.providers.JsonRpcProvider | null> = readable(
// 	null,
// 	(set: Subscriber<ethers.providers.JsonRpcProvider | null>) => {
// 		set(new ethers.providers.JsonRpcProvider('http://localhost:8545'));
// 		return () => null;
// 	}
// );

export const provider: Writable<ethers.providers.JsonRpcProvider | null> = writable();

export const contract = derived(provider, (values, set: Subscriber<ethers.Contract | null>) => {
	if (values !== null && values !== undefined) {
		console.log('setting contract', values);
		set(
			new ethers.Contract(
				'0x6915d0d999f13F7799fF709090038946451344f3',
				JSON.stringify(flashCard),
				values.getSigner()
			)
		);
	}
	return () => null;
});
