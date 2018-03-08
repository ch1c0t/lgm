axios = require 'axios'

module.exports =
  data: ->
    link: ""
    links: []
    total_amount_of_links: 0
    is_bottom_visible: no
    index_of_last_link: 39
  methods:
    addLink: ->
      response = await axios.post '/api/links', link: @link

      if response.status == 200
        @links.unshift response.data
        @index_of_last_link = @index_of_last_link + 1
        @get_total_amount_of_links()
        @link = ""
      else
        console.log "Invalid link: #{@link}"
    get_total_amount_of_links: ->
      response = await axios.get '/api/links/amount'
      @total_amount_of_links = response.data

    load_more_links: ({from, to})->
      response = await axios.get '/api/links',
        params:
          from: from
          to: to
      @links = @links.concat response.data

    check_if_bottom_is_visible: ->
      scrollY = window.scrollY
      visible = document.documentElement.clientHeight
      pageHeight = document.documentElement.scrollHeight
      bottomOfPage = visible + scrollY >= pageHeight
      bottomOfPage || pageHeight < visible

  created: ->
    @get_total_amount_of_links()
    @load_more_links from: 0, to: @index_of_last_link

    window.addEventListener 'scroll', =>
      @is_bottom_visible = @check_if_bottom_is_visible()

  watch:
    is_bottom_visible: (indeed) ->
      if indeed
        from = @index_of_last_link + 1
        to = @index_of_last_link + 40
        @load_more_links from: from, to: to
        @index_of_last_link = to
