module.exports = {
  theme: {
    extend: {
      colors: {
        brown: {
          100: '#f5e0d2', // Very light brown
          200: '#e3c4a7', // Light brown
          300: '#d1a27f', // Slightly darker light brown
          400: '#b88d55', // Medium-light brown
          500: '#a4733f', // Base brown color
          600: '#8a5b2d', // Darker brown
          700: '#6e4420', // Even darker brown
          800: '#4e2e14', // Almost black brown
        }
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    // other plugins
  ],
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ]
}

