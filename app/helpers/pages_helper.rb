module PagesHelper

	def available_statuses
		[['Published', 'published'], ['Draft', 'draft']]
	end

	def nested_page_items(page_items)

	  	page_items.map do |item, sub_item|
	    	render(item, :sub_item => sub_item )

		end.join.html_safe

	end

end
