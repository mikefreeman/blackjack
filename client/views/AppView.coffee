class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <span class="playerChips"></span>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> if @model.get('inHand') then @model.get('playerHand').hit()
    "click .stand-button": -> if @model.get('inHand') then @model.get('playerHand').stand()

  initialize: ->
    @render()

    @model .on 'deal', =>
      do @render

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.playerChips').html @model.get 'playerChips'
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
