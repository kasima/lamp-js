# Module dependencies.

mongoose   = require 'mongoose'
express    = require 'express'
controller = require './controller'

app = module.exports = express.createServer()
# app = module.exports = express()


# Configuration

app.configure ->
  # app.set('views', __dirname + '/views')
  # app.set('view engine', 'jade')
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(app.router)
  # app.use(express.static(__dirname + '/public'))

app.configure 'development', ->
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))

app.configure 'production', ->
  app.use(express.errorHandler())


# Routes

app.get('/', controller.index)
app.get('/letters', controller.letters)
app.get('/letters/:id/unlock', controller.unlock)

# DB

db = process.env.MONGOLAB_URI || 'mongodb://localhost/lamp'
mongoose.connect(db)

# Start Express
port = process.env.PORT || 3000
if !module.parent
  app.listen port, ->
    console.log("Express server listening on port %d in %s mode", port, app.settings.env);
