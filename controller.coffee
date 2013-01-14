Letter = require './letter'

writeJSONCallback = (res) ->
  (err, obj) ->
    if err?
      res.writeHead 422
    else
      res.writeHead 200, {"Content-Type": "text/json"}
      res.write JSON.stringify(obj)
    res.end()

exports.index = (req, res) ->
  res.redirect('http://olganunes.com/')

exports.letters = (req, res) ->
  Letter.unlocked writeJSONCallback(res)

exports.unlock = (req, res) ->
  Letter.findOne
    '_id': req.params.id
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
