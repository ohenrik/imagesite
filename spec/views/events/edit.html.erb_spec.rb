require 'spec_helper'

describe "events/edit" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :name => "MyString",
      :description => "MyText",
      :location => "MyString",
      :photo => nil
    ))
  end

  it "renders the edit event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", event_path(@event), "post" do
      assert_select "input#event_name[name=?]", "event[name]"
      assert_select "textarea#event_description[name=?]", "event[description]"
      assert_select "input#event_location[name=?]", "event[location]"
      assert_select "input#event_photo[name=?]", "event[photo]"
    end
  end
end
