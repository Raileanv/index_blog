# frozen_string_literal: true

module Users
  class TokensController < Devise::Api::TokensController
    private

    def sign_up_params
      additional_params = params.permit(:first_name, :last_name, :avatar)

      super.merge(additional_params)
    end
  end
end
