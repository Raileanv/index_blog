# frozen_string_literal: true

module Seeds
  class Articles < Seeds::Base
    ARTICLES_COUNT = 20_000

    def generate!
      Article.import(array_of_attributes(ARTICLES_COUNT))
    end

    private

    def klass_attributes
      mutex.synchronize do
        {
          title: FFaker::Book.title,
          description: FFaker::Lorem.paragraph,
          author_id: user_ids.sample,
          category_id: category_ids.sample,
          created_at: Time.now,
          updated_at: Time.now
        }
      end
    end

    def category_ids
      @category_ids ||= Category.pluck(:id)
    end

    def user_ids
      @user_ids ||= User.pluck(:id)
    end
  end
end
