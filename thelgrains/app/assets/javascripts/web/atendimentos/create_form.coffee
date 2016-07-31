(($) ->
  create_dial = $('#create-dialog')

  create_dial.dialog
    autoOpen: false
    modal: true
    width: 500
    height: 600
    buttons:
      'Cancelar': ->
        create_dial.dialog 'close'
        return
      'Criar':
        id: 'criar-bt'
        text: 'Criar'
        click: ->
          criarAtendimento()
          create_dial.dialog 'close'
          return

  criarAtendimento = ->
    # TODO: criar atendimento

  return
) jQuery
