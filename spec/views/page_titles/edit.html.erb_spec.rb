require 'spec_helper'

describe "page_titles/edit" do
  before(:each) do
    @page_title = assign(:page_title, stub_model(PageTitle,
      :title => "MyString"
    ))
  end

  it "renders the edit page_title form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", page_title_path(@page_title), "post" do
      assert_select "input#page_title_title[name=?]", "page_title[title]"
    end
  end
end
