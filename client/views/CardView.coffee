class window.CardView extends Backbone.View

  className: 'card'

  # template: _.template '<%= rankName %> of <%= suitName %>'

  template: _.template '<img src="img/cards/<%= rankName.toString().toLowerCase() %>-<%= suitName.toLowerCase() %>.png" />'
  backTemplate: _.template '<img src="img/card-back.png" />'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    if @model.get 'revealed'
      @$el.html @template @model.attributes
    else
      @$el.html @backTemplate @model.attributes
    # @$el.addClass 'covered' unless @model.get 'revealed'
