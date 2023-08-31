require 'rails_helper'

RSpec.describe ArticleTag, type: :model do
  describe 'associations' do
    let(:article) { create(:article) }
    let(:tag) { create(:tag) }
    let(:article_tag) { create(:article_tag, article:, tag:) }

    it 'belongs to an article' do
      expect(article_tag.article).to eq(article)
    end

    it 'belongs to a tag' do
      expect(article_tag.tag).to eq(tag)
    end
  end
end
