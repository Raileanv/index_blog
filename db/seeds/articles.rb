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
          author_id: User.pluck(:id).sample,
          category_id: Category.pluck(:id).sample,
          created_at: Time.now,
          updated_at: Time.now
        }
      end
    end
  end
end
