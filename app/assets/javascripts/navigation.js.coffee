ready = ->
	#Menu opening js
	$(".dropdown-toggle").click ->
		$(".dropdown-menu").hide()
		$(this).next().toggle()
		false

	# Close all open menus when openin a new one
	$(document).click ->
		$(".dropdown-menu").hide() != $(".dropdown-toggle").click


	# Listen for escape key to close menu 
	document.onkeydown = (evt) ->
		evt = evt or window.event
		$(".dropdown-menu").hide()  if evt.keyCode is 27
	


$(document).ready(ready)
$(document).on('page:load', ready)