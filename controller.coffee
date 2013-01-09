Letter = require './letter'

exports.index = (req, res) ->
  res.render('index', { title: 'Express' })

exports.letters = (req, res) ->
  letters = Letter.find {'unlocked': true}, (err, docs) ->
    res.writeHead 200, {"Content-Type": "text/json"}
    res.write JSON.stringify(docs)
    res.end()

exports.unlock = (req, res) ->
  console.log req.params
  debugger
  console.log req
  # letter = Letter.find {'_id': }
  # letter.save()

  # res.writeHead 200, {"Content-Type": "text/json"}
  # res.write JSON.stringify(letter)
  # res.end()