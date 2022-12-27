import adapter from '@sveltejs/adapter-auto';
import { vitePreprocess } from '@sveltejs/kit/vite';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	// Consult https://github.com/sveltejs/svelte-preprocess
	// for more information about preprocessors
	preprocess: vitePreprocess(),

	kit: {
		adapter: adapter(),
		alias: {
			'$fc-root': './src',
			'$fc-types': './src/types',
			'$fc-stores': './src/stores',
			'$fc-abis': './src/abis'
		}
	}
};

export default config;
