(($) ->
  search = $('#search')
  create_dial = $('#create-dialog')

  $('#novo').click (event) ->
    event.preventDefault()
    create_dial.dialog 'close' if create_dial.isOpen
    create_dial.dialog 'open'
    return

  $('#abrir-search').click (event) ->
    event.preventDefault()
    search.dialog 'close' if search.isOpen
    search.dialog 'open'
    return

  return
) jQuery
