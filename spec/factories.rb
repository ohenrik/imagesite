FactoryGirl.define do

  factory :user do |f|
    f.sequence(:email) { |n| "foo#{rand(1000).to_s}@example.com"}
    f.sequence(:username) { |n| "username#{rand(1000).to_s}"}
    f.sequence(:subdomain) { |n| "subdomain#{rand(1000).to_s}"}
    f.password "secret"
    f.password_confirmation "secret"
  end

  #factory :photo do |f|
  # f.
  #end

end