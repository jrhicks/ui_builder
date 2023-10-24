const execSync = require('child_process').execSync;
const ui_builder_path = execSync('bundle show ui_builder', { encoding: 'utf-8' });

const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    ui_builder_path.trim() + '/app/views/**/*.slim',
  ],
  theme: {
    extend: {
      spacing: {
        '128': '32rem',
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
