require 'spec_helper'

describe "public_code_files/show" do
  before(:each) do
    @public_code_file = assign(:public_code_file, stub_model(PublicCodeFile,
      :public_theme => nil,
      :name => "Name",
      :code => "MyText",
      :hierarchy => "Hierarchy",
      :available_to => "Available To",
      :available_in => "Available In",
      :static_file => "Static File",
      :display_name => "Display Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/Hierarchy/)
    rendered.should match(/Available To/)
    rendered.should match(/Available In/)
    rendered.should match(/Static File/)
    rendered.should match(/Display Name/)
  end
end
