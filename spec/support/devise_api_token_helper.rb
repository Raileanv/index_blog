module DeviseApiTokenHelper
  def sign_in!(resource_owner, token = nil, token_type = :access_token)
    token = FactoryBot.create(:devise_api_token, resource_owner: resource_owner) if token.blank?
    token_value = token.send(token_type)

    request.headers.merge!({ 'Authorization': "Bearer #{token_value}" })
  end
end
