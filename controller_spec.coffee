request  = require 'supertest'
app      = require '../app'
letter   = require '../letter'
mongoose = require('mongoose')

db = 'mongodb://localhost/lamp-tests'
mongoose.connect(db)

describe 'letter', ->
  describe 'GET /letters', ->
    it 'returns unlocked letters JSON', (done) ->
      request(app)
        .get('/letters')
        .set('Accept', 'application/json')
        .expect('Content-Type', /json/)
        .expect(200, done)

  describe 'PUT /api/letters/:id/unlock', ->
    describe 'with the correct key', ->
      it 'returns the unlocked letter'

    describe 'with an incorrect key', ->
      it 'returns an error message'
