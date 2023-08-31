class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :api

  DEFAULT_AVATAR = 'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y'.freeze

  has_one_attached :avatar
  has_many :articles, foreign_key: 'author_id', dependent: :destroy
  has_many :comments
  has_many :comment_votes, dependent: :destroy

  validates :avatar, content_type: %w[image/png image/svg+xml image/jpeg], size: { less_than: 5.megabytes }

  def avatar_url
    if avatar.attached?
      rails_blob_url(avatar, only_path: true)
    else
      DEFAULT_AVATAR
    end
  end

  def send_devise_notification(notification, *args)
    if notification == :confirmation_instructions
      devise_mailer.send(notification, self, *args).deliver_later(wait: 5.seconds)
    else
      super
    end
  end
end
