FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { 'password123' }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    admin { false }
    confirmed_at { Time.now }

    trait :banned do
      locked_at { Time.now }
    end
  end
end
