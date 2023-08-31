# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.string :category
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :category, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
