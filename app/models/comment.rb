class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  has_many :comment_votes

  ITEMS_PER_PAGE = 25

  scope :ordered_by_rating, -> { order(rating: :desc) }
  scope :with_pagination, ->(page, per_page = ITEMS_PER_PAGE) { page(page).per(per_page) }
end
