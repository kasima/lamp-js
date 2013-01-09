Letter = require './letter'

exports.index = (req, res) ->
  res.redirect('http://olganunes.com/')

exports.letters = (req, res) ->
  Letter.find {'unlocked': true}, (err, docs) ->
    res.writeHead 200, {"Content-Type": "text/json"}
    res.write JSON.stringify(docs)
    res.end()

exports.unlock = (req, res) ->
  Letter.findOne
    '_id': req.params.id
    'key': req.body.key
  , (err, letter) ->
    if letter
      if req.body.foundBy? && req.body.foundLocation?
        letter.foundBy = req.body.foundBy
        letter.foundLocation = req.body.foundLocation
        letter.foundDate = new Date
        letter.save()
        res.writeHead 200, {"Content-Type": "text/json"}
        res.write JSON.stringify(letter)
      else
        res.writeHead 422
    else
      res.writeHead 404

    res.end()
