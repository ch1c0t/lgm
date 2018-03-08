load_coffee =
  test: /\.coffee$/
  use: [
    'babel-loader'
    'coffee-loader'
  ]

load_vue_components =
  test: /\.vue$/
  use: 'vue-loader'

module.exports =
  entry: './src/main.coffee'
  output:
    path: "#{__dirname}/dist"
    filename: 'main.js'
  module:
    rules: [
      load_coffee
      load_vue_components
    ]
