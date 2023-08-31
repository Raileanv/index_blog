# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # Associations
  describe 'associations' do
    it { should have_many(:articles).with_foreign_key('author_id').dependent(:destroy) }
    it { should have_many(:comments) }
    it { should have_many(:comment_votes).dependent(:destroy) }
  end

  # Methods
  describe '#avatar_url' do
    it 'returns the attached avatar url if avatar is attached' do
      user = create(:user)
      user.avatar.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'image.jpeg')), filename: 'image.jpeg',
                         content_type: 'image/jpeg')
      expect(user.avatar_url).to include('/rails/active_storage/blobs/')
    end

    it 'returns the default avatar url if no avatar is attached' do
      user = create(:user)
      expect(user.avatar_url).to eq(User::DEFAULT_AVATAR)
    end
  end

  describe '#send_devise_notification' do
    let(:user) { create(:user) }

    it 'sends confirmation instructions with a delay' do
      expect(user).to receive(:devise_mailer).and_call_original
      user.send_devise_notification(:confirmation_instructions)
    end
  end
end
