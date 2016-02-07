var Templates = function () {
	this.renderTimeSlotsTemplate = function ($target, data) {
		var self = this;
		var client_id = $('#client').val();
		$target.empty();

		$.each(data, function (title, day) {
			var all_time_slot_templates = '';

			$.each(day, function(index, time_slot) {
				var formatted_hour = self.hourFormat(time_slot.hour);
				
				if( time_slot.client_id && time_slot.client_id.toString() === client_id ) {
					all_time_slot_templates += self.timeSlotTemplate(time_slot.id, formatted_hour, 'client_appt');
				} else {
					all_time_slot_templates += self.timeSlotTemplate(time_slot.id, formatted_hour, '');
				}
			});

			$target.append(self.allTimeSlotsTemplate(title, all_time_slot_templates));
		});
	};

	this.hourFormat = function (hour) {
		var hours = { '1': '1 AM', '2': '2 AM', '3': '3 AM', '4': '4 AM', '5': '5AM',
								  '6': '6 AM', '7': '7 AM', '8': '8 AM', '9': '9 AM', '10': '10 AM',
								  '11': '11 AM', '24': '12 AM', '13': '1 PM', '14': '2 PM', '15': '3 PM',
								  '16': '4 PM', '17': '5 PM', '18': '6 PM', '19': '7 PM', '20': '8 PM',
								  '21': '9 PM', '22': '10 PM', '23': '11 PM', '12': '12 PM' };

		return hours[hour];
	};

	this.renderFlags = function (client_id, element) {
		var $time_slots = $('.time_slot');
		var $element = $(element);

		if ( client_id !== null) {
			$element.addClass('client_appt');
			this.renderFlag('Your phone call has been scheduled!');
		} else {
			if ( $time_slots.hasClass('client_appt') && !$element.hasClass('client_appt') ) {
				this.renderFlag('You already have a phone call scheduled');			
			} else {
				$element.removeClass('client_appt');
				this.renderFlag('Your call has been canceled');
			}
		}
	};

	this.timeSlotTemplate = function (value, hour, client_class) {
	  return  "<div class='time_slot " + client_class + "' value='" + value + "'>" +
	    				hour +
	    			"</div>";
	};

	this.allTimeSlotsTemplate = function (title, time_slots) {
		return  "<div class='day_column'>" +
							"<div class='day-title'>" + 
	            	"<h6>" + title + "</h6>" +
	            "</div>" +
						  "<div id='time_slots'>" + time_slots + "</div>" + 
					  "</div>"
	};

	this.renderFlag = function (message) {
		var $flag = $('#flag');

		$flag.empty();
		$flag.append('<h6>' + message + '</h6>');
	};
}





