ready = ->
	$(".dropdown-toggle").click ->
		$(this).next().toggle()
		false
		
		#if $(this).next().css('display') == 'inline-block'
		#	$(this).next().css('display', 'none')
		#else
		#	$(this).next().css('display', 'inline-block')


$(document).ready(ready)
$(document).on('page:load', ready)