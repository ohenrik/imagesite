module MenusHelper

	def nested_menu_items(menu)

	  menu.map do |item, sub_item|
	    render(item, :sub_item => sub_item )

	  end.join.html_safe

	end

end
