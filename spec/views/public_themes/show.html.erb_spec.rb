require 'spec_helper'

describe "public_themes/show" do
  before(:each) do
    @public_theme = assign(:public_theme, stub_model(PublicTheme,
      :name => "Name",
      :zip => "Zip"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Zip/)
  end
end
