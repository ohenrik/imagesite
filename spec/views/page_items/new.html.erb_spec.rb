require 'spec_helper'

describe "page_items/new" do
  before(:each) do
    assign(:page_item, stub_model(PageItem,
      :position => 1,
      :page => nil,
      :pagable => nil
    ).as_new_record)
  end

  it "renders new page_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", page_items_path, "post" do
      assert_select "input#page_item_position[name=?]", "page_item[position]"
      assert_select "input#page_item_page[name=?]", "page_item[page]"
      assert_select "input#page_item_pagable[name=?]", "page_item[pagable]"
    end
  end
end
