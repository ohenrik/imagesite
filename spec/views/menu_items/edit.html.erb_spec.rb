require 'spec_helper'

describe "menu_items/edit" do
  before(:each) do
    @menu_item = assign(:menu_item, stub_model(MenuItem,
      :menu => nil
    ))
  end

  it "renders the edit menu_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", menu_item_path(@menu_item), "post" do
      assert_select "input#menu_item_menu[name=?]", "menu_item[menu]"
    end
  end
end
