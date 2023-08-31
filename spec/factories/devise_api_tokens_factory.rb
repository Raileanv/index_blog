FactoryBot.define do
  factory :devise_api_token, class: 'Devise::Api::Token' do
    association :resource_owner, factory: :user
    access_token { SecureRandom.hex(32) }
    refresh_token { SecureRandom.hex(32) }
    expires_in { 1.hour.to_i }
  end
end
