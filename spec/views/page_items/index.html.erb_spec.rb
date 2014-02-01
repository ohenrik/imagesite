require 'spec_helper'

describe "page_items/index" do
  before(:each) do
    assign(:page_items, [
      stub_model(PageItem,
        :position => 1,
        :page => nil,
        :pagable => nil
      ),
      stub_model(PageItem,
        :position => 1,
        :page => nil,
        :pagable => nil
      )
    ])
  end

  it "renders a list of page_items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
