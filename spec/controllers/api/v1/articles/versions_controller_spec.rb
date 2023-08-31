# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Articles::VersionsController, type: :controller do
  let(:user) { create(:user) }
  let(:article) { create(:article, author: user) }

  before do
    sign_in! user
  end

  describe 'GET #index' do
    it 'returns a list of versions for an article' do
      get :index, params: { article_id: article.id }
      expect(response).to be_successful
      expect(assigns(:versions)).to eq(article.versions)
    end
  end

  describe 'GET #show' do
    before { article.update(title: 'New title') }

    let(:version) { article.versions.first }

    it 'returns a specific version of an article' do
      get :show, params: { article_id: article.id, id: version.id }
      expect(response).to be_successful
      expect(assigns(:version).reify).to eq(version.reify)
    end
  end

  describe 'POST #rollback' do
    before { article.update(title: 'New title') }

    let(:version) { article.versions.last }

    context 'when rollback is successful' do
      it 'rolls back the article to a specific version' do
        post :rollback, params: { article_id: article.id, id: version.id }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Article rolled back successfully')
      end
    end
  end
end
