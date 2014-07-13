require 'spec_helper'

describe "tickets/index" do
  before(:each) do
    assign(:tickets, [
      stub_model(Ticket,
        :name => "Name",
        :price => "9.99",
        :currency => "Currency",
        :offer => nil,
        :customer => nil
      ),
      stub_model(Ticket,
        :name => "Name",
        :price => "9.99",
        :currency => "Currency",
        :offer => nil,
        :customer => nil
      )
    ])
  end

  it "renders a list of tickets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Currency".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
