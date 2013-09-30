# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	$('#container').isotope ->
    itemSelector : '.item',
	  layoutMode : 'fitRows'

	# filter items when filter link is clicked
	#$("#filters a").click ->
	#  selector = $(this).attr("data-filter")
	#  $('#container').isotope filter: selector
	#  false