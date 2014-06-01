require 'spec_helper'

describe "PasswordResets" do
	it "emails user when requesting password reset" do
		user = FactoryGirl.create(:user)
		visit login_path
		click_link "password"
		fill_in "email", :with => user.email
		click_button "Reset Password"
		current_path.should eq(login_path)
		flash[:notice].should eql("Email sent with password reset instrctions.")
		last_email.to.should include(user.email)
	end

	it "does not email invalid user when requesting password reset" do
		visit login_path
		click_link "password"
		fill_in "email", :with => "nobody@example.com"
		click_button "Reset Password"
		current_path.should eq(login_path)
		flash[:notice].should eql("Email sent with password reset instrctions.")
		last_email.should be_nil
	end

end

