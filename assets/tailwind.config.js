module.exports = {
  purge: [
    "../**/*html.eex",
    "../**/views/*.ex",
    "./js/**.js"
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
