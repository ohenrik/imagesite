# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
	$('.dd').nestable
		expandBtnHTML: "" #'<button data-action="expand"><i class="fa fa-caret-square-o-right text-muted"></i></button>',
		collapseBtnHTML: "" #'<button data-action="collapse"><i class="fa fa-caret-square-o-down text-muted"></i></button>'


	$('.tab').click (event) ->
		item = $(this).data("menu")
		menu = $(this).data("menu-id")
		$('.add-to-menu').each ->
			$(this).attr('href', $(this).attr('href').replace(/menu_id=./, "menu_id="+menu))

		$('.tab').parent().removeClass('active')
		$(this).parent().addClass('active')
		$('.tabbable').css('display', 'none')
		$('.'+item).css('display', 'block')
		event.preventDefault()


	$('.save-menu').click (event) ->
		event.preventDefault()
		order = $($(this).data('menu')).nestable('serialize')
		$.ajax
			type: 'post'
			url: $(this).data('update-url')
			data: { order: JSON.stringify(order) }
			dataType: 'script'
		$(this).button('loading')
		


#$(document).ready(ready)
#$(document).on('page:load', ready)