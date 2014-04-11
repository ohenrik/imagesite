require 'spec_helper'

describe "code_files/show" do
  before(:each) do
    @code_file = assign(:code_file, stub_model(CodeFile,
      :theme => nil,
      :name => "Name",
      :code => "MyText",
      :hierarchy => "Hierarchy"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/Hierarchy/)
  end
end
