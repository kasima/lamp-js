// Generated by CoffeeScript 1.4.0
(function() {
  var $, Lamp, server;

  $ = jQuery;

  server = 'http://lamp-an-olga-joint.herokuapp.com';

  Lamp = (function() {

    function Lamp() {}

    Lamp.prototype.letters = function(opts) {
      if (opts == null) {
        opts = {};
      }
      return $.ajax({
        url: server + '/letters',
        type: 'GET',
        crossDomain: true,
        success: function(data, status, xhr) {
          if (opts.success != null) {
            return opts.success(data, status, xhr);
          }
        },
        error: function(xhr, status) {
          if (opts.error != null) {
            return opts.error(xhr, status);
          }
        }
      });
    };

    Lamp.prototype.letter = function(id, opts) {
      if (opts == null) {
        opts = {};
      }
      return $.ajax({
        url: server + '/letters/' + id,
        type: 'GET',
        success: function(data, status, xhr) {
          if (opts.success != null) {
            return opts.success(data, status, xhr);
          }
        },
        error: function(xhr, status) {
          if (opts.error != null) {
            return opts.error(xhr, status);
          }
        }
      });
    };

    Lamp.prototype.unlock = function(id, foundBy, foundLocation, opts) {
      if (opts == null) {
        opts = {};
      }
      return $.ajax({
        url: server + '/letters/' + id + '/unlock',
        data: {
          foundBy: foundBy,
          foundLocation: foundLocation
        },
        type: 'POST',
        success: function(data, status, xhr) {
          if (opts.success != null) {
            return opts.success(data, status, xhr);
          }
        },
        error: function(xhr, status) {
          if (opts.error != null) {
            return opts.error(xhr, status);
          }
        }
      });
    };

    return Lamp;

  })();

  window.Lamp = Lamp;

}).call(this);
