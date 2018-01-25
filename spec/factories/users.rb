FactoryBot.define do
  factory :user do
    sequence(:email){|n| "user#{n}@factory.com" }
    first_name "MyString"
    middle_name "MyString"
    last_name "MyString"
    password "password"
    sequence(:phone){|n| "#{n}" }
    confirmed false

    trait :authenticated do
      sequence :login_uid do |n|
        SecureRandom.uuid
      end
    end
  end
end
