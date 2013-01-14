require '../spec_helper'

app    = require '../app'
async  = require 'async'
Letter = require '../letter'

describe 'Letter', ->
  beforeEach (done) ->
    # clear db
    Letter.find {}, (err, docs) ->
      async.map docs
      , (doc, callback) ->
        doc.remove callback
      , done

  describe 'static methods', ->
    describe '.unlocked', ->
      beforeEach (done) ->
        letters = [
          { unlocked: true },
          { unlocked: true },
          { locked: true }
        ]
        async.map letters
        , (attr, callback) ->
          letter = new Letter attr
          letter.save callback
        , done

      it "returns unlocked letters", (done) ->
        debugger
        Letter.unlocked (err, docs) ->
          docs.length.should.equal 2
          done()

  describe 'methods', ->
    describe '.appendFinder', ->
      beforeEach (done) ->
        @letter = new Letter
        done()

      it "adds the new finder to the end of the finders list", ->
        @finder =
          foundBy: 'Joey'
          foundLocation: 'At home'
        @letter.appendFinder @finder

        @letter.finders.length.should.equal 1

    describe '.flat', ->
      beforeEach (done) ->
        @letter = new Letter
          id: '1'
          key: 'key'
          unlocked: true
          finders: [
            {
              foundBy: "Stan"
              foundDate: Date.now()
            }
            {
              foundBy: "Joe"
              foundDate: Date.now() - 100
            }
          ]
        done()

      it "returns a letter object with the finder flattened to the first finder", (done) ->
        @letter.flat().should.have.property('foundBy', 'Joe')
        @letter.flat().foundCount.should.equal 2
        done()

