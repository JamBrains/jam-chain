// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

let plugin = require('tailwindcss/plugin')

module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex'
  ],
  theme: {
    extend: {
      // Warm-black monochrome palette (stone family), vibe-matched to
      // polkadot.com's dark tokens and openshore.io's near-black minimalism.
      colors: {
        bg: '#0f0f0f',            // page background
        surface: {
          DEFAULT: '#1c1917',     // cards, nav glass base
          2: '#292524',           // raised surfaces
        },
        line: {
          DEFAULT: '#292524',     // hairline borders
          strong: '#44403c',      // hover borders
        },
        ink: {
          DEFAULT: '#fafaf9',     // headings, primary text
          dim: '#d6d3d1',         // lead paragraphs
          mute: '#a8a29e',        // body text
          faint: '#78716c',       // eyebrows, captions
        },
      },
      fontFamily: {
        sans: ['system-ui', '-apple-system', '"system-ui"', '"Segoe UI"', 'Roboto', 'sans-serif'],
        mono: ['ui-monospace', '"SF Mono"', 'Menlo', 'Monaco', 'Consolas', 'monospace'],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    plugin(({addVariant}) => addVariant('phx-no-feedback', ['&.phx-no-feedback', '.phx-no-feedback &'])),
    plugin(({addVariant}) => addVariant('phx-click-loading', ['&.phx-click-loading', '.phx-click-loading &'])),
    plugin(({addVariant}) => addVariant('phx-submit-loading', ['&.phx-submit-loading', '.phx-submit-loading &'])),
    plugin(({addVariant}) => addVariant('phx-change-loading', ['&.phx-change-loading', '.phx-change-loading &']))
  ]
}
