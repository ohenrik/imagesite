require 'spec_helper'

describe "galleries/index" do
  before(:each) do
    assign(:galleries, [
      stub_model(Gallery,
        :title => "Title",
        :subtitle => "Subtitle",
        :description => "MyText",
        :gallery_type => "Gallery Type"
      ),
      stub_model(Gallery,
        :title => "Title",
        :subtitle => "Subtitle",
        :description => "MyText",
        :gallery_type => "Gallery Type"
      )
    ])
  end

  it "renders a list of galleries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Subtitle".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Gallery Type".to_s, :count => 2
  end
end
