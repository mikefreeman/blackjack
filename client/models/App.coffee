#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'playerChips', 1000
    @set 'betSize', 100
    do @deal

  playDealerHand: ->
    while (@get 'dealerHand') .scores()[0] < 17
      do (@get 'dealerHand') .hit
      do (@get 'dealerHand') .last() .flip

    if (@get 'dealerHand').scores()[0] > 21 then do @playerWin
    else if (@get 'dealerHand').scores()[0] < (@get 'playerHand').scores()
      do @playerWin
    else
      do @dealerWin

  checkPlayerHand: ->
    if (@get 'playerHand').scores()[0] > 21 then do @dealerWin
    else if (@get 'playerHand').scores()[0] == 21 then do (@get 'playerHand').stand

  playerWin: ->
    @set 'inHand', false
    console.log(@get 'playerChips')
    @set 'playerChips', @get 'playerChips' + @get 'betSize'
    console.log(@get 'playerChips')
    console.log('playerWin')
    console.log((@get 'playerHand') .scores())
    console.log((@get 'dealerHand') .scores())

    setTimeout((=> do @deal), 1500)

  dealerWin: ->
    @set 'inHand', false
    @set 'playerChips', @get 'playerChips' - @get 'betSize'
    console.log('dealerWin')
    console.log((@get 'playerHand') .scores())
    console.log((@get 'dealerHand') .scores())
    setTimeout((=> do @deal), 1500)

  deal: ->
    @set 'inHand', true
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @trigger 'deal', @
    setTimeout((=>
      do @flipCards
      do @checkPlayerHand
    ), 250)

    (@get 'playerHand') .on 'stand', =>
      (@get 'dealerHand') .at(0) .flip()
      do @playDealerHand

    (@get 'playerHand') .on 'hit', =>
      setTimeout((=>
        (@get 'playerHand') .last() .flip()
        do @checkPlayerHand
      ), 250)

  flipCards: ->
    (@get 'playerHand') .first() .flip()
    (@get 'playerHand') .last() .flip()
    (@get 'dealerHand') .last() .flip()


