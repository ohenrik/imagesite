require 'spec_helper'

describe "public_themes/index" do
  before(:each) do
    assign(:public_themes, [
      stub_model(PublicTheme,
        :name => "Name",
        :zip => "Zip"
      ),
      stub_model(PublicTheme,
        :name => "Name",
        :zip => "Zip"
      )
    ])
  end

  it "renders a list of public_themes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
  end
end
