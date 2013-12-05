require 'spec_helper'

describe "menu_items/index" do
  before(:each) do
    assign(:menu_items, [
      stub_model(MenuItem,
        :menu => nil
      ),
      stub_model(MenuItem,
        :menu => nil
      )
    ])
  end

  it "renders a list of menu_items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
