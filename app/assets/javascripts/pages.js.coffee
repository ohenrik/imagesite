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
		$(".rich-link").css('position', 'aboslute')
		event.preventDefault()


	# Insert selected image into the editor
	$(".select-photo-link").click (event) ->
		editor.focus() 		#Make sure the editor is selevted. if not previously selected by the user.
		editor.composer.commands.exec("insertImage", { src: $(this).data("url"), alt: "this is an image", title: "test" }) #Insert the image
		event.preventDefault() #prevent the browser from refreshing page
		

	# Close photo manager when close link is clicked
	$(".close-photo-manager").click (event) ->
		$('.page-photo-manager-background').hide()
		event.preventDefault()



$(document).ready(ready)
$(document).on('page:load', ready)