require 'rails_helper'

RSpec.describe Api::V1::Articles::CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:article) { create(:article, author: user) }
  let(:valid_attributes) { attributes_for(:comment) }
  let(:invalid_attributes) { { value: '' } }

  before do
    sign_in! user
  end

  describe 'GET #index' do
    it 'returns a list of comments for an article' do
      comment = create(:comment, article:)
      get :index, params: { article_id: article.id }
      expect(response).to be_successful
      expect(assigns(:comments)).to eq([comment])
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Comment' do
        expect do
          post :create, params: { article_id: article.id, **valid_attributes }
        end.to change(Comment, :count).by(1)
      end

      it 'renders a JSON response with the new comment' do
        post :create, params: { article_id: article.id, **valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new comment' do
        post :create, params: { article_id: article.id, **invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #like' do
    let(:comment) { create(:comment, article:) }

    it 'increases the rating of the comment by 1' do
      put :like, params: { article_id: article.id, id: comment.id }
      comment.reload
      expect(comment.rating).to eq(1)
    end
  end

  describe 'PUT #dislike' do
    let(:comment) { create(:comment, article:) }

    it 'decreases the rating of the comment by 1' do
      put :dislike, params: { article_id: article.id, id: comment.id }
      comment.reload
      expect(comment.rating).to eq(-1)
    end
  end
end
