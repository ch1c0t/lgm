import Vue from 'vue'

require './main.sass'

App = require('./components/App.vue').default

new Vue
  el: '#main'
  render: (h) -> h App
