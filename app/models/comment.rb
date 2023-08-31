# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  has_many :comment_votes

  default_scope -> { order(rating: :desc) }

  ITEMS_PER_PAGE = 25

  validates :value, presence: true, length: { minimum: 3, maximum: 300 }

  scope :ordered_by_rating, -> { order(rating: :desc) }
  scope :with_pagination, ->(page, per_page = ITEMS_PER_PAGE) { page(page).per(per_page) }
end
