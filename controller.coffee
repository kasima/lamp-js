_      = require 'underscore'
async  = require 'async'
Letter = require './letter'

writeJSONCallback = (res) ->
  (err, obj) ->
    if err?
      res.writeHead 422
    else
      res.writeHead 200,
        "Content-Type": "text/json"
        'Access-Control-Allow-Origin': '*'
      # console.log JSON.stringify obj
      res.write JSON.stringify(obj)
    res.end()

exports.index = (req, res) ->
  res.redirect('http://olganunes.com/')

exports.letters = (req, res) ->
  Letter.unlocked (err, letters) ->
    flattened = _.map letters
    , (letter) ->
      letter.flat()
    writeJSONCallback(res)(err, flattened)

exports.count = (req, res) ->
  locked = unlocked = null
  async.parallel [
    (callback) ->
      Letter.count {unlocked: true}, (err, count) ->
        unlocked = count
        callback()
    (callback) ->
      Letter.count {unlocked: false}, (err, count) ->
        locked = count
        callback()
  ]
  , ->
    json = {locked: locked, unlocked: unlocked}
    writeJSONCallback(res)(null, json)

exports.letter = (req, res) ->
  Letter.findOne
    'id': req.params.id
    'unlocked': true
  , (err, letter) ->
    if letter
      writeJSONCallback(res)(err, letter)
    else
      res.writeHead 404
      res.end()

exports.unlock = (req, res) ->
  Letter.findOne
    'id': req.params.id
    'key': req.body.key
  , (err, letter) ->
    if letter
      if req.body.foundBy? && req.body.foundLocation?
        letter.appendFinder
          foundBy: req.body.foundBy
          foundLocation: req.body.foundLocation
          foundDate: new Date
        letter.unlocked = true
        letter.save writeJSONCallback(res)
      else
        # no finder info posted
        res.writeHead 422
        res.end()
    else
      # no letter
      res.writeHead 404
      res.end()
