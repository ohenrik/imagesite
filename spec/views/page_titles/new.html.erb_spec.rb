require 'spec_helper'

describe "page_titles/new" do
  before(:each) do
    assign(:page_title, stub_model(PageTitle,
      :title => "MyString"
    ).as_new_record)
  end

  it "renders new page_title form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", page_titles_path, "post" do
      assert_select "input#page_title_title[name=?]", "page_title[title]"
    end
  end
end
