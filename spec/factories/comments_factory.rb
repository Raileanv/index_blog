# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    value { FFaker::Lorem.sentence }
    user
    article
  end
end
