axios = require 'axios'

module.exports =
  data: ->
    link: ""
    links: []
  methods:
    addLink: ->
      response = await axios.post '/api/links', link: @link

      if response.status == 200
        @links.unshift response.data
        @link = ""
      else
        console.log "Invalid link: #{@link}"

  created: ->
    response = await axios.get '/api/links'
    @links = response.data
