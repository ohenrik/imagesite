require 'spec_helper'

describe "code_files/index" do
  before(:each) do
    assign(:code_files, [
      stub_model(CodeFile,
        :theme => nil,
        :name => "Name",
        :code => "MyText",
        :hierarchy => "Hierarchy"
      ),
      stub_model(CodeFile,
        :theme => nil,
        :name => "Name",
        :code => "MyText",
        :hierarchy => "Hierarchy"
      )
    ])
  end

  it "renders a list of code_files" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Hierarchy".to_s, :count => 2
  end
end
