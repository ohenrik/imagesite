# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
	editor = new wysihtml5.Editor("wysihtml5-content", # id of textarea element
	  toolbar: "wysihtml5-content-toolbar" # id of toolbar element
	  stylesheets: "<%= stylesheet_path('wysiwyg') %>" # optional, css to style the editor's content
	  parserRules: wysihtml5ParserRules # defined in parser rules set
	) if $("#wysihtml5-content").length > 0


	excerpt = new wysihtml5.Editor("wysihtml5-excerpt", # id of textarea element
	  toolbar: "wysihtml5-excerpt-toolbar" # id of toolbar element
	  stylesheets: "<%= stylesheet_path('wysiwyg') %>" # optional, css to style the editor's content
	  parserRules: wysihtml5ParserRules # defined in parser rules set
	) if $("#wysihtml5-excerpt").length > 0


	$('#wysihtml5-content-images').click (event) ->
		$('.page-photo-manager-background').toggle()
		$('.page-photo-manager-background').css('height', $(document).height())
		$(".rich-link").css('position', 'aboslute')
		event.preventDefault()


	# Insert selected image into the editor
	$('#controll-insert-image-link').click (event) ->
		size = $('#controll-photo-size-input').val().trim()
		alt = $('#controll-photo-alt-input').val().trim()
		title = $('#controll-photo-title-input').val().trim()
		#Find the image size and use that one
		image_url = $(".selected-image").parent().data("url")
		filename = image_url.split('/').pop()
		new_url =  image_url.replace(filename, size + filename)
		editor.focus() 		#Make sure the editor is selevted. if not previously selected by the user.
		editor.composer.commands.exec("insertImage", { src: new_url , alt: alt, title: title }) #Insert the image
		event.preventDefault()


	# Select the image for further options
	$(".select-photo-link").click (event) ->
		$(".select-photo-link").find('img').css('width', '176px').css('height', '176px').css('border', '2px solid #636363').removeClass("selected-image") # reset all other images
		$(this).find('img').css('width', '172px').css('height', '172px').css('border', '4px solid #d5d6cb').addClass("selected-image") # "select" image
		$('.page-set-thumbnail').css('display', 'block').attr("href", $(".selected-image").parent().data("set-thumbnail"))
		$('#controll-insert-image-link ').css('display', 'block')
		$('#controll-photo-title-input').val($(".selected-image").parent().next().text().trim()) # get the title
		event.preventDefault() #prevent the browser from refreshing page
		

	# Close photo manager when close link is clicked
	$(".close-photo-manager").click (event) ->
		$('.page-photo-manager-background').hide()
		event.preventDefault()


	#$('')



$(document).ready(ready)
$(document).on('page:load', ready)