require 'spec_helper'

describe "public_code_files/index" do
  before(:each) do
    assign(:public_code_files, [
      stub_model(PublicCodeFile,
        :public_theme => nil,
        :name => "Name",
        :code => "MyText",
        :hierarchy => "Hierarchy",
        :available_to => "Available To",
        :available_in => "Available In",
        :static_file => "Static File",
        :display_name => "Display Name"
      ),
      stub_model(PublicCodeFile,
        :public_theme => nil,
        :name => "Name",
        :code => "MyText",
        :hierarchy => "Hierarchy",
        :available_to => "Available To",
        :available_in => "Available In",
        :static_file => "Static File",
        :display_name => "Display Name"
      )
    ])
  end

  it "renders a list of public_code_files" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Hierarchy".to_s, :count => 2
    assert_select "tr>td", :text => "Available To".to_s, :count => 2
    assert_select "tr>td", :text => "Available In".to_s, :count => 2
    assert_select "tr>td", :text => "Static File".to_s, :count => 2
    assert_select "tr>td", :text => "Display Name".to_s, :count => 2
  end
end
