axios = require 'axios'

module.exports =
  data: ->
    link: ""
    links: []
    total_amount_of_links: 0
  methods:
    addLink: ->
      response = await axios.post '/api/links', link: @link

      if response.status == 200
        @links.unshift response.data
        @get_total_amount_of_links()
        @link = ""
      else
        console.log "Invalid link: #{@link}"
    get_total_amount_of_links: ->
      response = await axios.get '/api/links/amount'
      @total_amount_of_links = response.data

  created: ->
    @get_total_amount_of_links()
    response = await axios.get '/api/links'
    @links = response.data
