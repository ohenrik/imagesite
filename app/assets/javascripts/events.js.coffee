# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
	$('.date-field').datetimepicker
		format:'d.m.Y',
		#step: 15,
		validateOnBlur: false,
		scrollInput: false,
		inline:false,
		timepicker:false

	$('.time-field').datetimepicker
		format:'H:i',
		step: 15,
		validateOnBlur: false,
		scrollInput: false,
		inline:false,
		datepicker:false