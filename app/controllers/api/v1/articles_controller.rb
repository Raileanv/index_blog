module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :set_article, only: %i[show update destroy]
      before_action :check_ownership, only: %i[update destroy]

      # GET api/v1/articles
      def index
        @articles = if params[:query].present?
                      Article.search_by_criteria(params[:query]).ordered.with_pagination(params[:page],
                                                                                         params[:per_page])
                    else
                      Article.ordered.with_pagination(params[:page], params[:per_page])
                    end

        if params[:start_date].present? && params[:end_date].present?
          start_date = Date.parse(params[:start_date])
          end_date = Date.parse(params[:end_date])

          @articles = @articles.created_between(start_date, end_date)
        end

        render json: {
          articles: @articles,
          meta: {
            total_pages: @articles.total_pages,
            current_page: @articles.current_page,
            next_page: @articles.next_page,
            prev_page: @articles.prev_page,
            total_count: @articles.total_count
          }
        }
      end

      # GET api/v1/articles/:id
      def show
        render json: @article.as_json(include: :comments)
      end

      # POST api/v1/articles
      def create
        @article = current_user.articles.build(article_params)
        if @article.save
          render json: @article, status: :created
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      # PUT api/v1/articles/:id
      def update
        if @article.update(article_params)
          render json: @article
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      # DELETE api/v1/articles/:id
      def destroy
        @article.discard
        head :no_content
      end

      private

      def set_article
        @article = Article.find(params[:id])
      end

      def check_ownership
        return if @article.author == current_user

        render json: { error: 'You are not authorized to perform this action' }, status: :unauthorized
      end

      def article_params
        params.permit(:title, :description, :status, :category_id, :cover, :tag_list)
      end
    end
  end
end
