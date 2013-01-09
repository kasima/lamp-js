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
  type: String
  foundBy: String
  foundLocation: String
  foundDate: Date

module.exports = mongoose.model('Letter', Letter)