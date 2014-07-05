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


	editor = new wysihtml5.Editor("wysihtml5-content",
	  toolbar: "wysihtml5-content-toolbar"
	  parserRules: wysihtml5ParserRules
	)

	$('form').on 'click', '.add_fields', (event) ->
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'), 'g')
		$(this).before($(this).data('fields').replace(regexp, time))
		event.preventDefault()

	$('form').on 'click', '.remove_fields', (event) ->
		$(this).prev('input[type=hidden]').val('1')
		$($(this).data("type-id")).hide()
		event.preventDefault()