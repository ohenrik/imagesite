require 'spec_helper'

describe "productions/new" do
  before(:each) do
    assign(:production, stub_model(Production,
      :name => "MyString",
      :description => "MyText",
      :photo => nil
    ).as_new_record)
  end

  it "renders new production form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", productions_path, "post" do
      assert_select "input#production_name[name=?]", "production[name]"
      assert_select "textarea#production_description[name=?]", "production[description]"
      assert_select "input#production_photo[name=?]", "production[photo]"
    end
  end
end
