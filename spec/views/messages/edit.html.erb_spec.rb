require 'spec_helper'

describe "messages/edit" do
  before(:each) do
    @message = assign(:message, stub_model(Message,
      :subject => "MyString",
      :content => "MyText",
      :sender_email => "MyString",
      :sender_name => "MyString",
      :sender_id => 1,
      :sender_type => "MyString",
      :receiver_id => 1,
      :receiver_type => "MyString",
      :message_type => "MyString"
    ))
  end

  it "renders the edit message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", message_path(@message), "post" do
      assert_select "input#message_subject[name=?]", "message[subject]"
      assert_select "textarea#message_content[name=?]", "message[content]"
      assert_select "input#message_sender_email[name=?]", "message[sender_email]"
      assert_select "input#message_sender_name[name=?]", "message[sender_name]"
      assert_select "input#message_sender_id[name=?]", "message[sender_id]"
      assert_select "input#message_sender_type[name=?]", "message[sender_type]"
      assert_select "input#message_receiver_id[name=?]", "message[receiver_id]"
      assert_select "input#message_receiver_type[name=?]", "message[receiver_type]"
      assert_select "input#message_message_type[name=?]", "message[message_type]"
    end
  end
end
