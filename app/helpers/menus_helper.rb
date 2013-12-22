module MenusHelper

	def nested_menu_items(item)

	  item.map do |item, sub_item|
	    render(item) +
	    	(content_tag(:lo, nested_menu_items(sub_item), class: "dd-list") if sub_item.present?)
	  end.join.html_safe

	end

end
