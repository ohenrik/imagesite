# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
	content = new wysihtml5.Editor("wysihtml5-content", # id of textarea element
	  toolbar: "wysihtml5-content-toolbar" # id of toolbar element
	  stylesheets: "<%= stylesheet_path('wysiwyg') %>" # optional, css to style the editor's content
	  parserRules: wysihtml5ParserRules # defined in parser rules set
	)


	excerpt = new wysihtml5.Editor("wysihtml5-excerpt", # id of textarea element
	  toolbar: "wysihtml5-excerpt-toolbar" # id of toolbar element
	  stylesheets: "<%= stylesheet_path('wysiwyg') %>" # optional, css to style the editor's content
	  parserRules: wysihtml5ParserRules # defined in parser rules set
	)

	#$(document).click ->
	#	editor.composer.commands.exec("insertImage", { src: "http://url.com/foo.jpg", alt: "this is an image" })



$(document).ready(ready)
$(document).on('page:load', ready)