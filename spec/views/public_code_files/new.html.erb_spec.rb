require 'spec_helper'

describe "public_code_files/new" do
  before(:each) do
    assign(:public_code_file, stub_model(PublicCodeFile,
      :public_theme => nil,
      :name => "MyString",
      :code => "MyText",
      :hierarchy => "MyString",
      :available_to => "MyString",
      :available_in => "MyString",
      :static_file => "MyString",
      :display_name => "MyString"
    ).as_new_record)
  end

  it "renders new public_code_file form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", public_code_files_path, "post" do
      assert_select "input#public_code_file_public_theme[name=?]", "public_code_file[public_theme]"
      assert_select "input#public_code_file_name[name=?]", "public_code_file[name]"
      assert_select "textarea#public_code_file_code[name=?]", "public_code_file[code]"
      assert_select "input#public_code_file_hierarchy[name=?]", "public_code_file[hierarchy]"
      assert_select "input#public_code_file_available_to[name=?]", "public_code_file[available_to]"
      assert_select "input#public_code_file_available_in[name=?]", "public_code_file[available_in]"
      assert_select "input#public_code_file_static_file[name=?]", "public_code_file[static_file]"
      assert_select "input#public_code_file_display_name[name=?]", "public_code_file[display_name]"
    end
  end
end
