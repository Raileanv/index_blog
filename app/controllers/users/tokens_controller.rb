class Users::TokensController < Devise::Api::TokensController
  def sign_in
    super
  end

  private

  def sign_up_params
    additional_params = params.permit(:first_name, :last_name, :avatar)

    super.merge(additional_params)
  end
end
