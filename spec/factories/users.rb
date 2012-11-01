# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    country_code '+86'
    sequence(:phone) {|n| 13917794404 + n }
    sequence(:name) {|n| "user_#{n}" }
    email { "#{name}@example.com" }
    password 'password'
    password_confirmation 'password'
  end
end
