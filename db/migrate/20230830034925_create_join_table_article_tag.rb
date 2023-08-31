# frozen_string_literal: true

class CreateJoinTableArticleTag < ActiveRecord::Migration[7.0]
  def change
    create_join_table :articles, :tags, table_name: :article_tags do |t|
      t.index %i[article_id tag_id]
      t.index %i[tag_id article_id]
    end
  end
end
