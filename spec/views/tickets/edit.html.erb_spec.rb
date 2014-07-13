require 'spec_helper'

describe "tickets/edit" do
  before(:each) do
    @ticket = assign(:ticket, stub_model(Ticket,
      :name => "MyString",
      :price => "9.99",
      :currency => "MyString",
      :offer => nil,
      :customer => nil
    ))
  end

  it "renders the edit ticket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", ticket_path(@ticket), "post" do
      assert_select "input#ticket_name[name=?]", "ticket[name]"
      assert_select "input#ticket_price[name=?]", "ticket[price]"
      assert_select "input#ticket_currency[name=?]", "ticket[currency]"
      assert_select "input#ticket_offer[name=?]", "ticket[offer]"
      assert_select "input#ticket_customer[name=?]", "ticket[customer]"
    end
  end
end
