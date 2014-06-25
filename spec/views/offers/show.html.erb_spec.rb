require 'spec_helper'

describe "offers/show" do
  before(:each) do
    @offer = assign(:offer, stub_model(Offer,
      :name => "Name",
      :price => "9.99",
      :currency => "Currency",
      :capacity => 1,
      :offerable_id => 2,
      :offerable_type => "Offerable Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/9.99/)
    rendered.should match(/Currency/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Offerable Type/)
  end
end
