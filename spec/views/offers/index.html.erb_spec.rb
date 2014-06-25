require 'spec_helper'

describe "offers/index" do
  before(:each) do
    assign(:offers, [
      stub_model(Offer,
        :name => "Name",
        :price => "9.99",
        :currency => "Currency",
        :capacity => 1,
        :offerable_id => 2,
        :offerable_type => "Offerable Type"
      ),
      stub_model(Offer,
        :name => "Name",
        :price => "9.99",
        :currency => "Currency",
        :capacity => 1,
        :offerable_id => 2,
        :offerable_type => "Offerable Type"
      )
    ])
  end

  it "renders a list of offers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Currency".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Offerable Type".to_s, :count => 2
  end
end
