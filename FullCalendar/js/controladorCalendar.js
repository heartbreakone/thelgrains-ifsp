$(document).ready(function() {	
	var zone = "03:30";
	var currentMousePos = {
	    x: -1,
	    y: -1
	};
		jQuery(document).on("mousemove", function (event) {
        currentMousePos.x = event.pageX;
        currentMousePos.y = event.pageY;
    });
	$('#external-events .fc-event').each(function() {

			// store data so the calendar knows to render an event upon drop
			$(this).data('event', {
				title: $.trim($(this).text()), // use the element's text as the event title
				stick: true // maintain when user navigates (see docs on the renderEvent method)
			});

			// make the event draggable using jQuery UI
			$(this).draggable({
				zIndex: 999,
				revert: true,      // will cause the event to go back to its
				revertDuration: 0  //  original position after the drag
			});

		});
		$('#calendar').fullCalendar({
			events: 'https://thelgrains.herokuapp.com/feed.json',
			utc: true,
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			editable: true,
			droppable: true, 
			eventLimit: true,
			//selectable: true,
			//selectHelper: true,
			slotDuration: '00:15:00',
			eventReceive: function(event){
				var title2 = event.title;
				var start2 = event.start.format("YYYY-MM-DD[T]HH:MM:SS");
				var startzone = start2;
				var enviar = "{"+'"'+"event"+'"'+":"+JSON.stringify({title:""+title2,start_time:""+startzone,end_time:""+startzone,all_day:"false",user_id:'1'})+"}";
				console.log(enviar);
				$.ajax({
		    		url: 'https://thelgrains.herokuapp.com/feed.json',
					data: enviar,
		    		type: 'POST',
					contentType: 'application/json;',
		    		dataType: 'json',
		    		success: function(response){
		    			event.id = response.eventid;
		    			$('#calendar').fullCalendar('updateEvent',event);
		    		},
		    		error: function(xhr, textStatus, error){
						console.log(xhr.statusText);
						console.log(textStatus);
						console.log(error);
		    		}
		    	});
				$('#calendar').fullCalendar('updateEvent',event);
				console.log(event);
			},
			eventDrop: function(event, delta, revertFunc) {
			console.log("AHEHUAEUHAEHUEAHUAEHUEAUHEAHUAEUHAEHU")
		        var title2 = event.title;
				var start2 = event.start.format("YYYY-MM-DD[T]HH:MM:SS");
				var startzone = start2+zone;
				var end2 = (event.end == null) ? start : event.end.format();
				var endzone = end2+zone;
				var enviar = "{"+'"'+"event"+'"'+":"+JSON.stringify({title:""+title2,start_time:""+startzone,end_time:""+endzone,allDay:"false",user_id:'1'})+"}";
		        $.ajax({
					url: 'https://thelgrains.herdaseqaweasedqweasdeweqseqeaseqwes='+event.id,
					data: enviar,
					type: 'PATCH',
					dataType: 'json',
					contentType: 'application/json;',
					success: function(response){
						if(response.status != 'success')		    				
						revertFunc();
					},
					error: function(xhr, textStatus, error){		    			
						revertFunc();
						console.log(xhr.statusText);
						console.log(textStatus);
						console.log(error);
					}
				});
		    },
			eventClick: function(event, jsEvent, view) {
		    	console.log(event.id);
		          var title2 = prompt('Nome do agendamento:', event.title, { buttons: { Ok: true, Cancel: false} });
				var enviar = "{"+'"'+"event"+'"'+":"+JSON.stringify({title:""+title2})+"}";
		          if (title2){
		              event.title = title2;
		              $.ajax({
				    		url: 'https://thelgrains.herokuapp.com/feed/'+event.id+'.json',
				    		data: enviar,
				    		type: 'PUT',
							contentType: 'application/json;',
				    		dataType: 'json',
				    		success: function(response){				    			
		              				$('#calendar').fullCalendar('updateEvent',event);
				    		},
				    		error: function(xhr, textStatus, error){		    			
								console.log(xhr.statusText);
								console.log(textStatus);
								console.log(error);
				    		}
				    	});
		          }
			},
			eventResize: function(event, delta, revertFunc) {
				var title2 = event.title;
		        var start2 = event.start.format();
		        var end2 = (event.end == null) ? start : event.end.format();
				var startzone = start2+zone;
				var endzone = end2+zone;
				var enviar = "{"+'"'+"event"+'"'+":"+JSON.stringify({start_time:""+startzone,end_time:""+endzone,all_day:"false"})+"}";
				$.ajax({
				    		url: 'https://thelgrains.herokuapp.com/feed/'+event.id+'.json',
				    		data: enviar,
				    		type: 'PUT',
							contentType: 'application/json;',
				    		dataType: 'json',
							
				    		success: function(response){				    			
		              				$('#calendar').fullCalendar('updateEvent',event);
				    		},
				    		error: function(xhr, textStatus, error){		    			
								console.log(xhr.statusText);
								console.log(textStatus);
								console.log(error);
				    		}
				    	});
		    },
			eventDragStop: function (event, jsEvent, ui, view) {
			    if (isElemOverDiv()) {
						$.ajax({
				    		url: 'https://thelgrains.herokuapp.com/feed/'+event.id+'.json',
				    		type: 'DELETE',
							contentType: 'application/json;',
				    		dataType: 'json',
				    		success: function(response){
				    			console.log(response);
				    			$('#calendar').fullCalendar('removeEvents');
            					getFreshEvents();	
				    		},
				    		error: function(xhr, textStatus, error){		    			
								console.log(xhr.statusText);
								console.log(textStatus);
								console.log(error);
				    		}
			    		});
					   
				}
			}
		});
		function getFreshEvents(){
		$('#calendar').fullCalendar('addEventSource','https://thelgrains.herokuapp.com/feed.json');
	}


	function isElemOverDiv() {
        var trashEl = jQuery('#calendar');

        var ofs = trashEl.offset();

        var x1 = ofs.left;
        var x2 = ofs.left + trashEl.outerWidth(true);
        var y1 = ofs.top;
        var y2 = ofs.top + trashEl.outerHeight(true);

        if (currentMousePos.x <= x1 || currentMousePos.x >= x2 &&
            currentMousePos.y <= y1 || currentMousePos.y >= y2) {
            return true;
        }
        return false;
    }


	});