var EventBindings = function () {
	this.templates = new Templates();

	this.addMonthSelectBinding = function () {
		var self = this;
		var $monthSelect = $('#month_select');
		var coach_id = $('#coach').val();

		$monthSelect.on('change', function() {
			self.renderTimeSlot($monthSelect.val(), coach_id);
		});
	};

	this.addHourBinding = function () {
		var self = this;
		var $time_slot =  $('.time_slot');

		$time_slot.on('click', function(e) { 
			var $this = $(this);
			var id = $this.attr('value');
			$('#flag').empty();

			self.addRemoveScheduledTimeSlot(id, $this);
		});
	};

	this.renderTimeSlot = function (month, coach_id) {
		var self = this;

		$.get('/time_slots/' + month + '/coach/' + coach_id, function( data ) {
			self.templates.renderTimeSlotsTemplate($('#available_times'), data);
			self.addHourBinding();
		});
	};

	this.addRemoveScheduledTimeSlot = function (id, element) {
		var self = this;

		$.post( '/time_slots/' + id, function( data ) {
			self.templates.renderFlags(data.client_id, element);
		});
	}
}











