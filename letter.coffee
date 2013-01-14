_        = require 'underscore'
mongoose = require 'mongoose'
Schema   = mongoose.Schema

LetterSchema = new Schema
  id:
    type: String
    index: true
    default: ''
  key:
    type: String
    index: true
    default: ''
  unlocked:
    type: Boolean
    default: false
  finders: [{
    foundBy: String
    foundLocation: String
    foundDate:
      type: Date
      default: Date.now
  }]
  data:
    type: Schema.Types.Mixed
    default: {}

LetterSchema.statics.unlocked = (callback) ->
  this.find {'unlocked': true}, callback

LetterSchema.methods.appendFinder = (finder) ->
  this.finders.push finder

LetterSchema.methods.flat = ->
  sorted = _.sortBy @finders
  , (finder) ->
    finder.foundDate
  finder = _.first sorted

  return {
    _id: @_id
    id: @id
    key: @key
    unlocked: @unlocked
    data: @data
    foundBy: finder? && finder.foundBy || ''
    foundLocation: finder? && finder.foundLocation || ''
    foundDate: finder? && finder.foundDate || ''
    foundCount: @finders.length
  }

module.exports = mongoose.model('Letter', LetterSchema)