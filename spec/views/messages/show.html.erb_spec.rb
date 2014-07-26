require 'spec_helper'

describe "messages/show" do
  before(:each) do
    @message = assign(:message, stub_model(Message,
      :subject => "Subject",
      :content => "MyText",
      :sender_email => "Sender Email",
      :sender_name => "Sender Name",
      :sender_id => 1,
      :sender_type => "Sender Type",
      :receiver_id => 2,
      :receiver_type => "Receiver Type",
      :message_type => "Message Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Subject/)
    rendered.should match(/MyText/)
    rendered.should match(/Sender Email/)
    rendered.should match(/Sender Name/)
    rendered.should match(/1/)
    rendered.should match(/Sender Type/)
    rendered.should match(/2/)
    rendered.should match(/Receiver Type/)
    rendered.should match(/Message Type/)
  end
end
