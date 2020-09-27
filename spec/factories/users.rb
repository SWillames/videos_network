require 'ffaker'

FactoryBot.define do
  factory :user do
    first_name {FFaker::Name.first_name}
    last_name {FFaker::Name.last_name}
    user_name {FFaker::InternetSE.user_name("#{first_name} - #{last_name}") }
    email {FFaker::Internet.safe_email}
    password {FFaker::Internet.password}
  end
end
