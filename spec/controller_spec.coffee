require '../spec_helper'

request     = require 'supertest'
async       = require 'async'
app         = require '../app'
Letter      = require '../letter'

describe 'letter', ->
  fixtures = [
    { id: 1, unlocked: true }
    { id: 2, unlocked: true }
    { id: 3, key: 'correct', unlocked: false }
  ]

  beforeEach (done) ->
    Letter.find {}, (err, docs) ->
      # clear db
      async.map docs
      , (doc, callback) ->
        doc.remove callback
      , ->
        # create fixtures
        async.map fixtures
        , (attr, callback) ->
          letter = new Letter attr
          letter.save callback
        , done

  describe 'GET /letters', ->
    it 'returns unlocked letters JSON', (done) ->
      that = this
      request(app)
        .get('/letters')
        .set('Accept', 'application/json')
        .expect('Content-Type', /json/)
        .expect(200)
        .end (err, res) ->
          return done(err) if err
          results = JSON.parse(res.text)
          results.length.should.equal 2
          done()
          # includes the first person who unlocked and a count of unlockers

  describe 'GET /letters/:id', ->
    # Includes a list of all finders

  describe 'GET /letters/count', ->
    # Returns locked and unlocked count

  describe 'POST /letters/:id/unlock', ->
    beforeEach (done) ->
      Letter.findOne { unlocked: false }, (err, doc) =>
        @locked = doc
        done()

    describe 'with the correct key', ->
      it 'returns the unlocked letter', (done) ->
        request(app)
          .post('/letters/' + @locked.id + '/unlock')
          .send
            key: 'correct'
            foundBy: 'Joey'
            foundLocation: 'The Park'
          .set('Accept', 'application/json')
          .expect('Content-Type', /json/)
          .expect(200)
          .end (err, res) ->
            throw err if err
            result = JSON.parse(res.text)
            result.unlocked.should.be.true
            result.finders[0].foundBy.should.equal 'Joey'
            result.finders[0].foundDate.should.exist
            done()

      describe 'with missing fields', ->
        it 'returns 422', (done) ->
          request(app)
            .post('/letters/' + @locked.id + '/unlock')
            .send
              key: 'correct'
            .expect(422)
            .end(done)

    describe 'with an incorrect key', ->
      it 'returns a 404', (done) ->
        request(app)
          .post('/letters/' + @locked.id + '/unlock')
          .send
            key: 'incorrect'
          .expect(404, done)

    describe 'with a bad id', ->
      it 'returns a 404', (done) ->
        request(app)
          .post('/letters/123/unlock')
          .expect(404, done)

