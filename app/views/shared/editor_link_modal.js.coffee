$('#link-modal-dialog').html('<%= escape_javascript(render( :partial => "shared/editor_link_modal", locals: { items: @items, editor: @editor }, :formats => [:html])) %>');
$('#linkModal').modal('show');


$('.wysihtml5-select-link').click (event) ->
	$('#href-input').val($(this).data('link'))
	$('#title-input').val($(this).data('name'))
	$('#href-input').focus()
	event.preventDefault()


$('#editorInsertLink').click (event) ->
	eval(<%= @editor %>).focus()
	if $('#target-input').is(':checked')
		eval(<%= @editor %>).composer.commands.exec("createLink", { href: $('#href-input').val(), target: "_blank", rel: "nofollow", text: $('#text-input').val() });
	else
		eval(<%= @editor %>).composer.commands.exec("createLink", { href: $('#href-input').val(), rel: "nofollow", text: $('#text-input').val() });
	event.preventDefault()