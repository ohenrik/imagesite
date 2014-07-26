require 'spec_helper'

describe "messages/index" do
  before(:each) do
    assign(:messages, [
      stub_model(Message,
        :subject => "Subject",
        :content => "MyText",
        :sender_email => "Sender Email",
        :sender_name => "Sender Name",
        :sender_id => 1,
        :sender_type => "Sender Type",
        :receiver_id => 2,
        :receiver_type => "Receiver Type",
        :message_type => "Message Type"
      ),
      stub_model(Message,
        :subject => "Subject",
        :content => "MyText",
        :sender_email => "Sender Email",
        :sender_name => "Sender Name",
        :sender_id => 1,
        :sender_type => "Sender Type",
        :receiver_id => 2,
        :receiver_type => "Receiver Type",
        :message_type => "Message Type"
      )
    ])
  end

  it "renders a list of messages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Sender Email".to_s, :count => 2
    assert_select "tr>td", :text => "Sender Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Sender Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Receiver Type".to_s, :count => 2
    assert_select "tr>td", :text => "Message Type".to_s, :count => 2
  end
end
