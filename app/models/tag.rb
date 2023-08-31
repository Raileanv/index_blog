# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :article_tags
  has_many :articles, through: :article_tags

  validates :name, presence: true, uniqueness: true
  before_save :downcase_name

  private

  def downcase_name
    self.name = name.downcase
  end
end
