require 'spec_helper'

describe "menu_items/new" do
  before(:each) do
    assign(:menu_item, stub_model(MenuItem,
      :menu => nil
    ).as_new_record)
  end

  it "renders new menu_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", menu_items_path, "post" do
      assert_select "input#menu_item_menu[name=?]", "menu_item[menu]"
    end
  end
end
