require 'spec_helper'

describe "page_titles/index" do
  before(:each) do
    assign(:page_titles, [
      stub_model(PageTitle,
        :title => "Title"
      ),
      stub_model(PageTitle,
        :title => "Title"
      )
    ])
  end

  it "renders a list of page_titles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
