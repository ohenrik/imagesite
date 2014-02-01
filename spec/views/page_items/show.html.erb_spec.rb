require 'spec_helper'

describe "page_items/show" do
  before(:each) do
    @page_item = assign(:page_item, stub_model(PageItem,
      :position => 1,
      :page => nil,
      :pagable => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(//)
    rendered.should match(//)
  end
end
