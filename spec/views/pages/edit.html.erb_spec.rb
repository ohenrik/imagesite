require 'spec_helper'

describe "pages/edit" do
  before(:each) do
    @page = assign(:page, stub_model(Page,
      :title => "MyString",
      :content => "MyText",
      :excerpt => "MyText",
      :status => "MyString"
    ))
  end

  it "renders the edit page form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", page_path(@page), "post" do
      assert_select "input#page_title[name=?]", "page[title]"
      assert_select "textarea#page_content[name=?]", "page[content]"
      assert_select "textarea#page_excerpt[name=?]", "page[excerpt]"
      assert_select "input#page_status[name=?]", "page[status]"
    end
  end
end
