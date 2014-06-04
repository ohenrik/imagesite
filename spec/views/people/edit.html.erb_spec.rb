require 'spec_helper'

describe "people/edit" do
  before(:each) do
    @person = assign(:person, stub_model(Person,
      :first_name => "MyString",
      :last_name => "MyString",
      :title => "MyString",
      :description => "MyText",
      :email => "MyString",
      :phone => "MyString",
      :mobile_phone => "MyString",
      :photo => nil
    ))
  end

  it "renders the edit person form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", person_path(@person), "post" do
      assert_select "input#person_first_name[name=?]", "person[first_name]"
      assert_select "input#person_last_name[name=?]", "person[last_name]"
      assert_select "input#person_title[name=?]", "person[title]"
      assert_select "textarea#person_description[name=?]", "person[description]"
      assert_select "input#person_email[name=?]", "person[email]"
      assert_select "input#person_phone[name=?]", "person[phone]"
      assert_select "input#person_mobile_phone[name=?]", "person[mobile_phone]"
      assert_select "input#person_photo[name=?]", "person[photo]"
    end
  end
end
