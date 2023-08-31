# frozen_string_literal: true

class CreateCommentVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :comment_votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true
      t.integer :vote

      t.timestamps
    end
  end
end
