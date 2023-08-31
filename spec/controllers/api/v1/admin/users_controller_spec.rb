require 'rails_helper'

RSpec.describe Api::V1::Admin::UsersController, type: :controller do
  let(:admin) { create(:user, admin: true) }
  let(:user) { create(:user) }

  before do
    sign_in! admin
  end

  describe 'PUT #ban' do
    it 'bans a user' do
      put :ban, params: { id: user.id }
      user.reload
      expect(user.access_locked?).to be_truthy
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('User has been banned.')
    end
  end

  describe 'PUT #unban' do
    before do
      user.lock_access!
    end

    it 'unbans a user' do
      put :unban, params: { id: user.id }
      user.reload
      expect(user.access_locked?).to be_falsey
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('User ban has been removed.')
    end
  end
end
