request  = require 'supertest'
mongoose = require 'mongoose'
async    = require 'async'
app      = require './app'
Letter   = require './letter'

db = 'mongodb://localhost/lamp-tests'
mongoose.connect(db)

describe 'letter', ->
  fixtures = [
    { unlocked: true }
    { unlocked: true }
    { key: 'correct', unlocked: false }
  ]

  beforeEach (done) ->
    Letter.find {}, (err, docs) ->
      async.map docs
      , (doc, callback) ->
        doc.remove callback
      , ->
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

  describe 'POST /letters/:id/unlock', ->
    beforeEach (done) ->
      Letter.findOne { unlocked: false }, (err, doc) =>
        @locked = doc
        done()

    describe 'with the correct key', ->
      it 'returns the unlocked letter', (done) ->
        request(app)
          .post('/letters/' + @locked._id + '/unlock')
          .send
            key: 'correct'
            foundBy: 'Joey'
            foundLocation: 'The Park'
          .set('Accept', 'application/json')
          .expect('Content-Type', /json/)
          .expect(200)
          .end (err, res) ->
            result = JSON.parse(res.text)
            result.foundBy.should.equal 'Joey'
            result.foundLocation.should.equal 'The Park'
            result.should.have.property 'foundDate'
            done()

      describe 'with missing fields', ->
        it 'returns 422', (done) ->
          request(app)
            .post('/letters/' + @locked._id + '/unlock')
            .send
              key: 'correct'
            .expect(422)
            .end(done)

    describe 'with an incorrect key', ->
      it 'returns a 404', (done) ->
        request(app)
          .post('/letters/' + @locked._id + '/unlock')
          .send
            key: 'incorrect'
          .expect(404, done)

    describe 'with a bad id', ->
      it 'returns a 404', (done) ->
        request(app)
          .post('/letters/123/unlock')
          .expect(404, done)

