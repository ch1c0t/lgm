axios = require 'axios'

module.exports =
  data: ->
    link: ""
    links: []
  methods:
    addLink: ->
      @links.unshift @link
      @link = ""
  created: ->
    response = await axios.get '/api/links'
    @links = response.data
