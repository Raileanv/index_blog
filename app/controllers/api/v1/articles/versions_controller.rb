module Api::V1::Articles
  class VersionsController < ApplicationController
    before_action :set_article
    before_action :check_ownership

    # GET /articles/:article_id/versions
    def index
      @versions = @article.versions
      render json: @versions
    end

    # GET /articles/:article_id/versions/:id
    def show
      @version = @article.versions.find(params[:id])
      render json: @version.reify
    end

    # POST /articles/:article_id/versions/:id/rollback
    def rollback
      version = @article.versions[params[:id].to_i]
      if version.reify
        version.reify.save!
        render json: { message: 'Article rolled back successfully' }, status: :ok
      else
        render json: { error: 'Failed to rollback article' }, status: :unprocessable_entity
      end
    end

    private

    def set_article
      @article = Article.find(params[:article_id])
    end

    def check_ownership
      return if @article.author == current_user

      render json: { error: 'You are not authorized to perform this action' }, status: :unauthorized
    end
  end
end
