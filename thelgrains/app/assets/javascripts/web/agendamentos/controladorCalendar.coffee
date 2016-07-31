$(document).ready ->
  # inicia o fullCalendar
  $('#calendar').fullCalendar
    editable: true
    theme: true
    droppable: true
    header:
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    defaultView: 'month',
    height: 500,
    slotMinutes: 30,
    eventSources: [{
      url: '/feed.json',
    }],

    timeFormat: 'hh:mm'
    dragOpacity: "0.75"

    # drop de evento interno
    eventDrop: (event, dayDelta, minuteDelta, allDay, revertFunc) ->
      updateEvent(event)

    # resize de evento
    eventResize: (event, dayDelta, minuteDelta, revertFunc) ->
      updateEvent(event)

    # drop de evento externo
    eventReceive: (event) ->
      createEvent(event)
      $('#calendar').fullCalendar 'refetchEvents'

    # dragstop de evento
    # eventDragStop: (event, jsEvent, ui, view) ->
    #   if isElemOverDiv()
    #     deleteEvent(event)
    #   return

    drop: (data, jsEvent, ui) ->
      if event_valid()
        set_event_data()
      else
        alert 'Preencha os campos!'

  # REST events
  getEvent = (the_event) ->
    $.get '/feed/' + the_event.id

  deleteEvent = (the_event) ->
    $.delete '/feed/' + the_event.id

  updateEvent = (the_event) ->
    $.update "/feed/" + the_event.id, stringify_event(the_event)

  createEvent = (the_event) ->
    $.ajax
      url: '/feed'
      data: stringify_event(the_event)
      type: 'POST'
      success: (data, stat, xhr) ->
        alert 'Agendado com sucesso!'



  # takes only usable content
  stringify_event = (the_event) ->
    if the_event.user_id == undefined
      return event:
        title: the_event.title
        start_time: "" + the_event.start.format('YYYY-MM-DD[T]HH:MM:SS')
        end_time: "" + the_event.start.format('YYYY-MM-DD[T]HH:MM:SS')
        description: the_event.description
        cliente_id: the_event.cliente_id
    else
      return event:
        title: the_event.title
        start_time: "" + the_event.start.format('YYYY-MM-DD[T]HH:MM:SS')
        end_time: "" + the_event.start.format('YYYY-MM-DD[T]HH:MM:SS')
        description: the_event.description
        user_id: the_event.user_id
        cliente_id: the_event.cliente_id
    return

  # set data from form
  set_event_data = (event, ui) ->
    $('#new-event').data 'event',
      title: $('#new_title').val()
      stick: true
      user_id: $('#user_id').val()
      cliente_id: $('#cliente_id').val()
    $('#new-event').data 'duration', $('#duracao').val() || '01:00'
    return

  # check if form is filled
  event_valid = ->
    title = $('#new_title').val()
    user = $('#user_id').val()
    if title == '' || title == undefined || user == '' || user == undefined
      return false
    return true

  $('#new-event').draggable
    zIndex: 999
    revert: true
    revertDuration: 250
    scroll: true
    containment: '#drag-container'
    drag: (event, ui) ->
      return true if event_valid
      return false

  return
return
