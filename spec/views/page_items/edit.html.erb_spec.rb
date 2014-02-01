require 'spec_helper'

describe "page_items/edit" do
  before(:each) do
    @page_item = assign(:page_item, stub_model(PageItem,
      :position => 1,
      :page => nil,
      :pagable => nil
    ))
  end

  it "renders the edit page_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", page_item_path(@page_item), "post" do
      assert_select "input#page_item_position[name=?]", "page_item[position]"
      assert_select "input#page_item_page[name=?]", "page_item[page]"
      assert_select "input#page_item_pagable[name=?]", "page_item[pagable]"
    end
  end
end
