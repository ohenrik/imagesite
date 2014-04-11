# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
	editor3 = CodeMirror.fromTextArea(code_area,
		name: 'text/html'
		htmlMode: true
		theme: 'default'
		lineNumbers: true
		indentUnit: 4
		keyMap: 'sublime'
		matchBrackets: true
		autoCloseBrackets: true
		matchTags: true
		autoCloseTags: true
		extraKeys: 
			"Ctrl-Enter": (cm) ->
				cm.setOption "fullScreen", !cm.getOption("fullScreen")
				return

			Esc: (cm) ->
				cm.setOption "fullScreen", false
				return
	)


