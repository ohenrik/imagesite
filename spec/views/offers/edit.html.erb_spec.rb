require 'spec_helper'

describe "offers/edit" do
  before(:each) do
    @offer = assign(:offer, stub_model(Offer,
      :name => "MyString",
      :price => "9.99",
      :currency => "MyString",
      :capacity => 1,
      :offerable_id => 1,
      :offerable_type => "MyString"
    ))
  end

  it "renders the edit offer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", offer_path(@offer), "post" do
      assert_select "input#offer_name[name=?]", "offer[name]"
      assert_select "input#offer_price[name=?]", "offer[price]"
      assert_select "input#offer_currency[name=?]", "offer[currency]"
      assert_select "input#offer_capacity[name=?]", "offer[capacity]"
      assert_select "input#offer_offerable_id[name=?]", "offer[offerable_id]"
      assert_select "input#offer_offerable_type[name=?]", "offer[offerable_type]"
    end
  end
end
