(($) ->
  dial = $('#dialog')
  search = $('#search')

  dial.dialog
    autoOpen: false
    modal: true
    width: 500
    height: 600
    buttons:
      'Cancelar': ->
        dial.dialog 'close'
        return
      'Finalizar':
        id: 'fin'
        text: 'Finalizar'
        click: ->
          contabilizar()
          dial.dialog 'close'
          return

  search.dialog
    autoOpen: false
    modal: true
    width: 500
    height: 400

  $('.abrir').click (event) ->
    event.preventDefault()
    dial.dialog 'close' if dial.isOpen
    fill_popup_dial($(this).parent().parent().attr('meta'))
    dial.dialog 'open'
    return

  $('#abrir-search').click (event) ->
    event.preventDefault()
    search.dialog 'close' if search.isOpen
    search.dialog 'open'
    return

  fill_popup_dial = (id) ->
    $.getJSON "/caixa/#{id}", (data, status, q) ->
      form = $('#dialog-form')
      $('#atendimento-id').val(data.id)
      $('#valor-pagar').val data.gasto_total
      aten = "Funcionário: #{data.funcionario}"
      if data.ajudantes.length > 0
        aten += '<br>Ajudantes:'
        for aj in data.ajudantes
          aten += "#{aj.nome} "
          if aj.vezes > 1
            aten += "(#{aj.vezes}x)"
          aten += '<br>'
      $('#funcionario').html(aten)

      if data.cliente == ''
        $('#cliente').html('<a>Cadastrar Cliente</a>')
      else
        $('#cliente').html("Cliente: #{data.cliente}")
      $('#gasto-add').html("R$ #{data.gasto_add}")
      $('#total').val(data.gasto_total)
      td = "<td>#{data.servico}</td><td>R$ #{data.servico_preco}</td>"
      $('#servicos').html(td)
      return
    return

  $('#valor-pago').blur ->
    if valor_troco() >= 0
      $('#fin').prop('disabled', false)
      $('#troco').val(valor_troco())
    else
      $('#fin').prop('disabled', true)
      $('#troco').val(0)
    return

  valor_troco = ->
    return parseFloat($('#valor-pago').val()) - parseFloat($('#valor-pagar').val())


  contabilizar = ->
    id = $('#atendimento-id').val()
    if parseFloat($('#valor-pago').val()) >= parseFloat($('#valor-pagar').val())
      $('#pago').val(true)
    else
      $('#pago').val(false)
    $.ajax
      url: "/caixa/#{id}"
      method: 'patch'
      data: $('#dialog-form').serialize()
      success: (data) ->
        window.location.href = data.redirect
    return
) jQuery
