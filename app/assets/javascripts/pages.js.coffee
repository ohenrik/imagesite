# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

	#editor = new wysihtml5.Editor("wysihtml5-content", # id of textarea element
	#  toolbar: "wysihtml5-content-toolbar" # id of toolbar element
	#  stylesheets: "<%= stylesheet_path('wysiwyg') %>" # optional, css to style the editor's content
	#  parserRules: wysihtml5ParserRules # defined in parser rules set
	#) if $("#wysihtml5-content").length > 0


	$('#contentModal-button').click (event) ->
		alert editor.selected.getValue() #.exec("createLink", { href: "http://google.com", target: "_blank", rel: "nofollow", text: "Google" });
		event.preventDefault()


	$('#wysihtml5-content-images').click (event) ->
		$('.page-photo-manager-background').toggle()
		$('.page-photo-manager-background').css('height', $(document).height())
		$(".rich-link").css('position', 'aboslute')
		event.preventDefault()


	# Insert selected image into the editor
	$('#controll-insert-image-link').click (event) ->
		size = $('#controll-photo-size-input').val().trim()
		alt_text = $('#controll-photo-alt-input').val().trim()
		title = $('#controll-photo-title-input').val().trim()
		#Find the image size and use that one
		image_url = $(".selected-link").data("url")
		filename = image_url.split('/').pop()
		new_url =  image_url.replace(filename, size + filename)
		editor.focus() 		#Make sure the editor is selevted. if not previously selected by the user.
		editor.composer.commands.exec("insertImage", { src: new_url , alt: alt_text, title: title }) #Insert the image
		$(".selected-link").removeClass("selected-link").find('img').removeClass("selected-image")
		$('#page-manager-controls').hide()
		event.preventDefault()


	# Select the image for further options
	$(".select-photo-link").click (event) ->
		$(".select-photo-link").removeClass("selected-link").find('img').removeClass("selected-image") # reset all other images
		$(this).addClass("selected-link").find('img').addClass("selected-image") # "select" image
		$('#page-manager-controls').css('display', 'block').appendTo($(this).next())
		$('#page-manager-controls').css('width', $(this).find('img').width() )
		$('#page-set-thumbnail').attr("href", $(".selected-image").parent().data("set-thumbnail"))
		$('#controll-photo-title-input').val($(".selected-image").parent().next().next().text().trim()) # get the title
		event.preventDefault() #prevent the browser from refreshing page
		


	$('#page-set-thumbnail').click (event) ->
		$(this).button('loading')



	#$('.page_items').nestable
	#	rootClass: 'page_items'
	#	handleClass: 'list-item-image'
	#	expandBtnHTML: "" #'<button data-action="expand"><i class="fa fa-caret-square-o-right text-muted"></i></button>',
	#	collapseBtnHTML: "" #'<button data-action="collapse"><i class="fa fa-caret-square-o-down text-muted"></i></button>'
	#	maxDepth: 1
	#	group: 1

	#$('.page_sub_items').nestable
	#	rootClass: 'page_sub_items'
	#	handleClass: 'list-item-image'
	#	expandBtnHTML: "" #'<button data-action="expand"><i class="fa fa-caret-square-o-right text-muted"></i></button>',
	#	collapseBtnHTML: "" #'<button data-action="collapse"><i class="fa fa-caret-square-o-down text-muted"></i></button>'
	#	maxDepth: 1
	#	group: 1


	#$('#page_items').sortable
	#	items: 'div'
	#	handle: '.handle'
	#	connectWith: '.sortable_gallery'


	$(document).on 'change', '#page_item_no_item_link', (event) ->
		if $('#custom_link_field').attr("disabled")
			$('#custom_link_field').removeAttr('disabled')
		else
			$('#custom_link_field').attr("disabled", "disabled")


	# sorting page items

	$(document).on 'click', '.order-up', (event) ->
		$($(this).data('page-item')).prev().insertAfter($(this).data('page-item'))
		sort_items()
		event.preventDefault()


	$(document).on 'click', '.order-down', (event) ->
		$($(this).data('page-item')).next().insertBefore($(this).data('page-item'))
		sort_items()
		event.preventDefault()

	# sending the updated list to page_items controller.
	sort_items = () ->
		order = current_order()
		$.ajax
			type: 'post'
			url: '/page_items/sort_page_items'
			data: { order: JSON.stringify(order) }
			dataType: 'script'


	current_order = () ->
		page_item_order = []
		structure_item_order = []
		$('.page_item').each (i) ->
			if $(this).data('structure')
				$('.structure_item_' + $(this).data('id')).each ->
					structure_item_order.push id: $(this).data('id')
				page_item_order.push id: $(this).data('id'), children: structure_item_order
			else
				page_item_order.push id: $(this).data('id')
		page_item_order
		#alert page_item_order[0].children[0].id
		

	


		

#$(document).ready(ready)
#$(document).on('page:load', ready)