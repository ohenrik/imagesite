require 'spec_helper'

describe "tickets/show" do
  before(:each) do
    @ticket = assign(:ticket, stub_model(Ticket,
      :name => "Name",
      :price => "9.99",
      :currency => "Currency",
      :offer => nil,
      :customer => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/9.99/)
    rendered.should match(/Currency/)
    rendered.should match(//)
    rendered.should match(//)
  end
end
