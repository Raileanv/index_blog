class Article < ApplicationRecord
  include Rails.application.routes.url_helpers
  include Discard::Model
  include PgSearch::Model

  has_paper_trail

  PER_PAGE = 25
  VERSIONS_LIMIT = 5
  DEFAULT_COVER = 'https://dummyimage.com/300x300/8adc16/a97b60.png?text='.freeze

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

  default_scope -> { preload(:category).kept.published }

  belongs_to :author, class_name: 'User'
  belongs_to :category, optional: true
  has_many :article_tags
  has_many :tags, through: :article_tags
  has_many :comments

  has_one_attached :cover
  validates :cover, content_type: %w[image/png image/svg+xml image/jpeg], size: { less_than: 5.megabytes }
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }

  enum status: { hidden: 'hidden', published: 'published' }

  scope :ordered, -> { order(created_at: :desc) }
  scope :with_pagination, ->(page, per_page = PER_PAGE) { page(page).per(per_page) }
  scope :created_between, lambda { |start_date, end_date|
    where(created_at: start_date.beginning_of_day..end_date.end_of_day) if start_date.present? && end_date.present?
  }

  after_save :limit_number_of_versions

  def tag_list=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip.downcase).first_or_create!
    end.uniq
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def cover_url
    if cover.attached?
      rails_blob_url(cover, only_path: true)
    else
      DEFAULT_COVER
    end
  end

  def as_json(options = {})
    super(options).merge({
                           'cover_url' => cover_url
                         })
  end

  private

  def limit_number_of_versions
    versions.first.destroy while versions.size > VERSIONS_LIMIT
  end
end
