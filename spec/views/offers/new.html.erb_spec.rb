require 'spec_helper'

describe "offers/new" do
  before(:each) do
    assign(:offer, stub_model(Offer,
      :name => "MyString",
      :price => "9.99",
      :currency => "MyString",
      :capacity => 1,
      :offerable_id => 1,
      :offerable_type => "MyString"
    ).as_new_record)
  end

  it "renders new offer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", offers_path, "post" do
      assert_select "input#offer_name[name=?]", "offer[name]"
      assert_select "input#offer_price[name=?]", "offer[price]"
      assert_select "input#offer_currency[name=?]", "offer[currency]"
      assert_select "input#offer_capacity[name=?]", "offer[capacity]"
      assert_select "input#offer_offerable_id[name=?]", "offer[offerable_id]"
      assert_select "input#offer_offerable_type[name=?]", "offer[offerable_type]"
    end
  end
end
