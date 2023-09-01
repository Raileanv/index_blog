# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  # Associations
  it { should belong_to(:author).class_name('User') }
  it { should belong_to(:category).optional }
  it { should have_many(:article_tags) }
  it { should have_many(:tags).through(:article_tags) }
  it { should have_many(:comments) }

  # Validations
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least(3).is_at_most(100) }

  # Enum
  it {
    should define_enum_for(:status).with_values(hidden:    'hidden',
                                                published: 'published').backed_by_column_of_type(:string)
  }

  describe 'scopes' do
    let!(:article1) { create(:article, created_at: 1.day.ago) }
    let!(:article2) { create(:article, created_at: 2.days.ago) }

    describe '.ordered' do
      it 'orders articles by created_at in descending order' do
        expect(Article.ordered).to eq([article1, article2])
      end
    end

    describe '.created_between' do
      it 'returns articles created between given dates' do
        expect(Article.created_between(2.days.ago, Date.today).to_a).to include(article1, article2)
      end
    end
  end

  describe '#tag_list=' do
    let(:article) { create(:article) }

    it 'assigns tags to the article' do
      article.tag_list = 'tag1, tag2'
      expect(article.tags.map(&:name)).to contain_exactly('tag1', 'tag2')
    end
  end

  describe '#tag_list' do
    let(:article) { create(:article) }

    it 'returns a comma-separated list of tag names' do
      article.tag_list = 'tag1, tag2'
      expect(article.tag_list).to eq('tag1, tag2')
    end
  end

  describe 'callbacks' do
    let(:article) { create(:article) }

    context 'when there are more than VERSIONS_LIMIT versions' do
      before do
        (Article::VERSIONS_LIMIT + 1).times { article.update(title: FFaker::Lorem.word) }
      end

      it 'keeps only VERSIONS_LIMIT versions' do
        expect(article.versions.count).to eq(Article::VERSIONS_LIMIT)
      end
    end
  end
end
