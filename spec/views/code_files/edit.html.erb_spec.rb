require 'spec_helper'

describe "code_files/edit" do
  before(:each) do
    @code_file = assign(:code_file, stub_model(CodeFile,
      :theme => nil,
      :name => "MyString",
      :code => "MyText",
      :hierarchy => "MyString"
    ))
  end

  it "renders the edit code_file form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", code_file_path(@code_file), "post" do
      assert_select "input#code_file_theme[name=?]", "code_file[theme]"
      assert_select "input#code_file_name[name=?]", "code_file[name]"
      assert_select "textarea#code_file_code[name=?]", "code_file[code]"
      assert_select "input#code_file_hierarchy[name=?]", "code_file[hierarchy]"
    end
  end
end
