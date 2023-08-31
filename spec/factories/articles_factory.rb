# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { FFaker::Book.title }
    description { FFaker::Lorem.paragraph }
    category
    author { association(:user) }
    status { 'published' }
  end
end
