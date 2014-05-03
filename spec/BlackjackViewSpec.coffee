
assert = chai.assert

describe 'player', ->
  app = null

  beforeEach ->
    app = new App()

  describe 'check game play', ->
    it "should check for player bust", ->
      app.get('playerHand').at(0).set
        value: 10
        revealed: true
      app.get('playerHand').at(1).set
        value: 10
        revealed: true
      app.get('deck').last().set
        value: 4
        revealed: true
      app.get('playerHand').hit()
      assert.strictEqual app.get('playerHand').scores()[0], 24
