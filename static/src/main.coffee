import Vue from 'vue'

App = require('./components/App.vue').default

new Vue
  el: '#main'
  render: (h) -> h App
