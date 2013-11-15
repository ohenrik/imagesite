# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
	editor = new wysihtml5.Editor("wysihtml5-content", # id of textarea element
	  toolbar: "wysihtml5-content-toolbar" # id of toolbar element
	  stylesheets: "<%= stylesheet_path('wysiwyg') %>" # optional, css to style the editor's content
	  parserRules: wysihtml5ParserRules # defined in parser rules set
	)


	editor = new wysihtml5.Editor("wysihtml5-excerpt", # id of textarea element
	  toolbar: "wysihtml5-excerpt-toolbar" # id of toolbar element
	  stylesheets: "<%= stylesheet_path('wysiwyg') %>" # optional, css to style the editor's content
	  parserRules: wysihtml5ParserRules # defined in parser rules set
	)


$(document).ready(ready)
$(document).on('page:load', ready)