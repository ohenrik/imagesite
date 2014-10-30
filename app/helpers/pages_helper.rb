module PagesHelper

  def available_statuses
    [['Published', 'published'], ['Draft', 'draft']]
  end

  def nested_page_items(page_items, f)

      page_items.map do |item, sub_item|
        render("pages/page_item",  :sub_item => sub_item, :f => f)

    end.join.html_safe

  end

end
