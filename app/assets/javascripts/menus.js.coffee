# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = -> 
	$('.dd').nestable
		expandBtnHTML: "" #'<button data-action="expand"><i class="fa fa-caret-square-o-right text-muted"></i></button>',
		collapseBtnHTML: "" #'<button data-action="collapse"><i class="fa fa-caret-square-o-down text-muted"></i></button>'


	$('.tab').click (event) ->
		item = $(this).data("menu")
		menu = $(this).data("menu-id")
		$('.add-to-menu').each ->
			$(this).attr('href', $(this).attr('href').replace(/menu_id=./, "menu_id="+menu))

		$('.tab').parent().toggleClass('active')
		$('.tabbable').css('display', 'none')
		$('.'+item).css('display', 'block')
		event.preventDefault()


	#$('.dd').on "change", ->
	#	$("#tester").text JSON.stringify($(this).nestable('serialize'))
	#	$.post($(this).data('update-url'), $(this).sortable('serialize'))


$(document).ready(ready)
$(document).on('page:load', ready)