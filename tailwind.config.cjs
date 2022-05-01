/** @type {import('tailwindcss/types').Config} */
const config = {
  content: ['./src/**/*.{html,js,svelte,ts}'],
  theme: {
    extend: {},
  },
  plugins: [require('a17t')],
}

module.exports = config
