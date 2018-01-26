module.exports =
  data: ->
    link: ""
    links: []
  methods:
    addLink: ->
      @links.push @link
      @link = ""
