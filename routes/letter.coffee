exports.index = (req, res) ->
  res.send('letter index')

exports.new = (req, res) ->
  res.send('new letter')

exports.create = (req, res) ->
  res.send('create letter')

exports.show = (req, res) ->
  res.send('show letter ' + req.params.letter)

exports.edit = (req, res) ->
  res.send('edit letter ' + req.params.letter)

exports.update = (req, res) ->
  res.send('update letter ' + req.params.letter)

exports.destroy = (req, res) ->
  res.send('destroy letter ' + req.params.letter)
