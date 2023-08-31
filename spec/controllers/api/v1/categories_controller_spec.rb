# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do
  describe 'GET #index' do
    context 'when user is not authenticated' do
      it 'returns unauthorized status' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user is authenticated' do
      let(:user) { create(:user) }

      before do
        allow(controller).to receive(:current_user).and_return(user)
        allow(controller).to receive(:authenticate_devise_api_token!).and_return(true)
      end

      it 'returns a successful response' do
        get :index
        expect(response).to be_successful
      end

      it 'returns all categories' do
        category = create(:category)
        get :index
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.first['id']).to eq(category.id)
      end
    end

    context 'when user is banned' do
      let(:banned_user) { create(:user, :banned) }

      before do
        allow(controller).to receive(:current_user).and_return(banned_user)
        allow(controller).to receive(:authenticate_devise_api_token!).and_return(true)
      end

      it 'returns unauthorized status with a ban message' do
        get :index
        expect(response).to have_http_status(:unauthorized)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['error']).to eq('Your account has been banned')
      end
    end
  end
end
