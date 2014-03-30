# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
	$('.remove').click ->
		$(this).remove()


	
	$('#page-set-thumbnail').click (event) ->
		$(this).button('loading')

#$(document).ready(ready)
#$(document).on('page:load', ready)