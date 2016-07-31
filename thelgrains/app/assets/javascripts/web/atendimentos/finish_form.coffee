(($) ->
  $('.finalizar').click (event) ->
    event.preventDefault()
    $.update '/atendimentos/' + $(this).parent().parent().attr('meta'),
    { fechar: true }
    $(this).parent().parent().hide('fast')
) jQuery
