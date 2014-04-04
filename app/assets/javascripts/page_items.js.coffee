# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->

	$(document).on 'change', '#page_item_no_item_link', (event) ->
		if $('#custom_link_field').attr("disabled")
			$('#custom_link_field').removeAttr('disabled')
		else
			$('#custom_link_field').attr("disabled", "disabled")