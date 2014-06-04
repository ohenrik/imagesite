require 'spec_helper'

describe "people/index" do
  before(:each) do
    assign(:people, [
      stub_model(Person,
        :first_name => "First Name",
        :last_name => "Last Name",
        :title => "Title",
        :description => "MyText",
        :email => "Email",
        :phone => "Phone",
        :mobile_phone => "Mobile Phone",
        :photo => nil
      ),
      stub_model(Person,
        :first_name => "First Name",
        :last_name => "Last Name",
        :title => "Title",
        :description => "MyText",
        :email => "Email",
        :phone => "Phone",
        :mobile_phone => "Mobile Phone",
        :photo => nil
      )
    ])
  end

  it "renders a list of people" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Mobile Phone".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
