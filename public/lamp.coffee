$ = jQuery

server = 'http://lamp-an-olga-joint.herokuapp.com'

class Lamp
  letters: (opts={}) ->
    $.ajax
      url: server + '/letters'
      type: 'GET'

      success: (data, status, xhr) ->
        opts.success(data, status, xhr) if opts.success?
      error: (xhr, status) ->
        opts.error(xhr, status) if opts.error?


  count: (opts={}) ->
    $.ajax
      url: server + '/letters/count'
      type: 'GET'

      success: (data, status, xhr) ->
        opts.success(data, status, xhr) if opts.success?
      error: (xhr, status) ->
        opts.error(xhr, status) if opts.error?


  letter: (id, opts={}) ->
    $.ajax
      url: server + '/letters/' + id
      type: 'GET'

      success: (data, status, xhr) ->
        opts.success(data, status, xhr) if opts.success?
      error: (xhr, status) ->
        opts.error(xhr, status) if opts.error?

  unlock: (id, key, foundBy, foundLocation, opts={}) ->
    $.ajax
      url: server + '/letters/' + id + '/unlock'
      data:
        key: key
        foundBy: foundBy
        foundLocation: foundLocation
      type: 'POST'

      success: (data, status, xhr) ->
        opts.success(data, status, xhr) if opts.success?
      error: (xhr, status) ->
        opts.error(xhr, status) if opts.error?


window.Lamp = Lamp