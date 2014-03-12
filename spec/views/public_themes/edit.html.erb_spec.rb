require 'spec_helper'

describe "public_themes/edit" do
  before(:each) do
    @public_theme = assign(:public_theme, stub_model(PublicTheme,
      :name => "MyString",
      :zip => "MyString"
    ))
  end

  it "renders the edit public_theme form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", public_theme_path(@public_theme), "post" do
      assert_select "input#public_theme_name[name=?]", "public_theme[name]"
      assert_select "input#public_theme_zip[name=?]", "public_theme[zip]"
    end
  end
end
