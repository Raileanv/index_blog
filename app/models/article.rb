class Article < ApplicationRecord
  include Discard::Model
  include PgSearch::Model

  has_paper_trail

  PER_PAGE = 25
  VERSIONS_LIMIT = 5

  pg_search_scope :search_by_criteria,
                  against: [:title],
                  associated_against: {
                    author: %i[first_name last_name],
                    tags: [:name],
                    category: [:name]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }

  default_scope -> { kept.published }

  belongs_to :author, class_name: 'User'
  belongs_to :category, optional: true
  has_many :article_tags
  has_many :tags, through: :article_tags
  has_many :comments

  has_one_attached :cover
  validates :cover, content_type: %w[image/png image/svg+xml image/jpeg], size: { less_than: 5.megabytes }

  enum status: { hidden: 'hidden', published: 'published' }

  scope :ordered, -> { order(created_at: :desc) }
  scope :with_pagination, ->(page, per_page = PER_PAGE) { page(page).per(per_page) }

  after_save :limit_number_of_versions

  def tag_list=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip.downcase).first_or_create!
    end.uniq
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  private

  def limit_number_of_versions
    versions.first.destroy while versions.size > VERSIONS_LIMIT
  end
end
