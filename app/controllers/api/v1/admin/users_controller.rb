# frozen_string_literal: true

module Api
  module V1
    module Admin
      class UsersController < ApplicationController
        before_action :authenticate_admin! # Ensure the user is an admin

        def ban
          user = User.find(params[:id])
          user.lock_access!

          render json: { message: 'User has been banned.' }, status: :ok
        end

        def unban
          user = User.find(params[:id])
          user.unlock_access!

          render json: { message: 'User ban has been removed.' }, status: :ok
        end
      end
    end
  end
end
