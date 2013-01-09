mongoose = require('mongoose')
Schema = mongoose.Schema

Letter = new Schema()
Letter.add
  key:
    type: String
    index: true
  imageUrl: String
  soundUrl: String
  unlocked: Boolean
  foundBy: String
  foundDate: Date
  foundLocation: String
  type: String

module.exports = mongoose.model('Letter', Letter)