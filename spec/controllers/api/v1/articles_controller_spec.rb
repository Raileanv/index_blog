# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do
  let(:user) { create(:user) }
  let(:article) { create(:article, author: user) }

  before do
    sign_in!(user)
  end

  describe 'GET #index' do
    let!(:article1) { create(:article, title: 'Ruby on Rails') }
    let!(:article2) { create(:article, title: 'JavaScript') }
    let!(:article3) { create(:article, title: 'Python Django', created_at: 2.days.ago) }
    let!(:article4) { create(:article, title: 'Elixir Phoenix', created_at: 4.days.ago) }

    context 'when querying articles' do
      before do
        get :index, params: { query: 'Ruby' }
      end

      it 'returns articles that match the query' do
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response['articles'].length).to eq(1)
        expect(json_response['articles'].first['title']).to eq(article1.title)
      end
    end

    context 'when filtering articles by date' do
      before do
        get :index, params: { start_date: 3.days.ago.to_date.to_s, end_date: 1.day.ago.to_date.to_s }
      end

      it 'returns articles created between the start and end dates' do
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response['articles'].length).to eq(1)
        expect(json_response['articles'].first['title']).to eq(article3.title)
      end
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: article.id } }

    it 'returns the requested article' do
      expect(assigns(:article)).to eq(article)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_attributes) { attributes_for(:article) }

      before do
        post :create, params: valid_attributes
      end

      it 'creates a new article' do
        expect(Article.count).to eq(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { title: '' } }

      before do
        post :create, params: invalid_attributes
      end

      it 'does not create a new article' do
        expect(Article.count).to eq(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let(:new_title) { 'Updated Title' }

    before do
      put :update, params: { id: article.id, title: new_title }
    end

    it 'updates the article' do
      article.reload
      expect(article.title).to eq(new_title)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, params: { id: article.id } }

    it 'discards the article' do
      expect(Article.unscoped.count).to eq(1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
