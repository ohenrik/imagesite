require 'spec_helper'

describe "texts/edit" do
  before(:each) do
    @text = assign(:text, stub_model(Text,
      :content => "MyText"
    ))
  end

  it "renders the edit text form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", text_path(@text), "post" do
      assert_select "textarea#text_content[name=?]", "text[content]"
    end
  end
end
