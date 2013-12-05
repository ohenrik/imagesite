require 'spec_helper'

describe "menu_items/show" do
  before(:each) do
    @menu_item = assign(:menu_item, stub_model(MenuItem,
      :menu => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
