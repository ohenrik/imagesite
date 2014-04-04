# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

	$('.remove').click ->
		$(this).remove()

	$('.loading').click (event) ->
		$(this).button('loading')

#$(document).ready(ready)
#$(document).on('page:load', ready)