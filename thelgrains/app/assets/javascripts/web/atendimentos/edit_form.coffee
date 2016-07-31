(($) ->
  dial = $('#edit-dialog')
  dial.dialog
    autoOpen: false
    modal: true
    width: 500
    height: 600
    buttons:
      'Cancelar': ->
        dial.dialog 'close'
        return
      'Editar':
        id: 'fin'
        text: 'Finalizar'
        click: ->
          dial.dialog 'close'
          return

  $('.abrir').click (event) ->
    event.preventDefault()
    dial.dialog 'close' if dial.isOpen()
    fill_edit_dial($(this).parent().parent().attr('meta'))
    dial.dialog 'open'
    return

  fill_edit_dial = (id) ->
    $.getJSON "/atendimentos/#{id}", (data, status, q) ->
      form = $('#dialog-form')
      $('#atendimento-id').val(data.id)
      if data.cliente == ''
      else
      return
    return

) jQuery
