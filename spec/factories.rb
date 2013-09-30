FactoryGirl.define do

	factory :user do |f|
		f.sequence(:email) { |n| "foo#{n}@example.com"}
		f.sequence(:username) { |n| "username#{n}"}
		f.sequence(:subdomain) { |n| "subdomain#{n}"}
		f.password "secret"
		f.password_confirmation "secret"
	end

end