# frozen_string_literal: true

class CommentVote < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :vote, inclusion: { in: [1, -1] }
end
