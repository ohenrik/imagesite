require 'spec_helper'

describe "productions/edit" do
  before(:each) do
    @production = assign(:production, stub_model(Production,
      :name => "MyString",
      :description => "MyText",
      :photo => nil
    ))
  end

  it "renders the edit production form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", production_path(@production), "post" do
      assert_select "input#production_name[name=?]", "production[name]"
      assert_select "textarea#production_description[name=?]", "production[description]"
      assert_select "input#production_photo[name=?]", "production[photo]"
    end
  end
end
