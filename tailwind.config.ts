import type { Config } from 'tailwindcss'

export default {
  content: [
    './components/**/*.{js,vue,ts}',
    './layouts/**/*.vue',
    './pages/**/*.vue',
    './plugins/**/*.{js,ts}',
    './nuxt.config.{js,ts}',
  ],
  theme: {
    extend: {
      screens: {
        nav: '1125px',
      },
      fontFamily: {
        sans: ['"Neue Haas Grotesk Display Pro"', 'Helvetica Neue', 'Helvetica', 'Arial', 'sans-serif'],
      },
      colors: {
        ml: {
          black:  '#050505',
          dark:   '#0a0a0a',
          card:   '#0d0d0d',
          border: 'rgba(255,255,255,0.07)',
          muted:  'rgba(255,255,255,0.35)',
          subtle: 'rgba(255,255,255,0.12)',
          white:  '#ffffff',
        },
      },
      letterSpacing: {
        widest2: '0.2em',
        widest3: '0.3em',
      },
    },
  },
  plugins: [],
} satisfies Config
