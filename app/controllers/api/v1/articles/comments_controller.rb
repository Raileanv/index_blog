# frozen_string_literal: true

module Api
  module V1
    module Articles
      class CommentsController < ApplicationController
        before_action :set_article

        # rubocop:disable Metrics/MethodLength
        def index
          @comments = @article.comments.ordered_by_rating.with_pagination(params[:page], params[:per_page])

          render json: {
            comments: @comments,
            meta: {
              total_pages: @comments.total_pages,
              current_page: @comments.current_page,
              next_page: @comments.next_page,
              prev_page: @comments.prev_page,
              total_count: @comments.total_count
            }
          }
        end
        # rubocop:enable Metrics/MethodLength

        def create
          @comment = @article.comments.build(comment_params.merge(user: current_user))
          if @comment.save
            render json: @comment, status: :created
          else
            render json: @comment.errors, status: :unprocessable_entity
          end
        end

        def like
          vote(1)
        end

        def dislike
          vote(-1)
        end

        private

        def set_article
          @article = Article.find(params[:article_id])
        end

        def comment_params
          params.permit(:value, :rating)
        end

        def vote(value)
          @comment = @article.comments.find(params[:id])
          comment_vote = @comment.comment_votes.find_or_initialize_by(user: current_user)
          comment_vote.vote = value
          comment_vote.save!

          @comment.rating = @comment.comment_votes.sum(:vote)
          @comment.save!

          render json: { rating: @comment.rating }
        end
      end
    end
  end
end
