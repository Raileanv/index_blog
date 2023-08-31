# frozen_string_literal: true

FactoryBot.define do
  factory :comment_vote do
    user
    comment
    vote { [-1, 1].sample }
  end
end
