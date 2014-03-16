require 'spec_helper'

describe "page_titles/show" do
  before(:each) do
    @page_title = assign(:page_title, stub_model(PageTitle,
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
  end
end
