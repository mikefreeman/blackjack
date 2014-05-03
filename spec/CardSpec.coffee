assert = chai.assert

describe "card constructor", ->

  it "should create a card", ->
    card = new Card
      rank: 10
      suit: 1
    assert.strictEqual (card.get 'revealed'), true

describe "deck constructor", ->
  it "should create a card collection", ->
    collection = new Deck()
    assert.strictEqual collection.length, 52
