module.exports =
  data: ->
    link: ""
    links: []
  methods:
    addLink: ->
      @links.unshift @link
      @link = ""
