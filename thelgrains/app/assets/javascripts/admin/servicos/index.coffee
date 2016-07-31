$ ->
  $("#categoria").change ->
    # create a jquery object of the rows
    jo = $("tbody").find "tr"
    # show all the rows
    if @value is ''
      $('tbody').hide('fast')
      return
    if @value is 'all'
      jo.hide()
      $('tbody').show()
      jo.show('fast')
      return
    # Recusively filter the jquery object to get results.
    jo2 = jo.filter (i, v) ->
      return true if $(v).attr('cat') is $('#categoria ').val()
      return false
    # show the rows that match.
    jo.hide()
    $('tbody').show()
    jo2.show('fast')
