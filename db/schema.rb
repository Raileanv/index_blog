# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_831_051_355) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum'
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'article_tags', id: false, force: :cascade do |t|
    t.bigint 'article_id', null: false
    t.bigint 'tag_id', null: false
    t.index %w[article_id tag_id], name: 'index_article_tags_on_article_id_and_tag_id'
    t.index %w[tag_id article_id], name: 'index_article_tags_on_tag_id_and_article_id'
  end

  create_table 'articles', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.string 'category'
    t.bigint 'author_id', null: false
    t.bigint 'category_id'
    t.string 'status'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'discarded_at'
    t.index ['author_id'], name: 'index_articles_on_author_id'
    t.index ['category_id'], name: 'index_articles_on_category_id'
    t.index ['discarded_at'], name: 'index_articles_on_discarded_at'
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'comment_votes', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'comment_id', null: false
    t.integer 'vote'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['comment_id'], name: 'index_comment_votes_on_comment_id'
    t.index ['user_id'], name: 'index_comment_votes_on_user_id'
  end

  create_table 'comments', force: :cascade do |t|
    t.text 'value'
    t.integer 'rating', default: 0, null: false
    t.bigint 'user_id', null: false
    t.bigint 'article_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['article_id'], name: 'index_comments_on_article_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'devise_api_tokens', force: :cascade do |t|
    t.string 'resource_owner_type', null: false
    t.bigint 'resource_owner_id', null: false
    t.string 'access_token', null: false
    t.string 'refresh_token'
    t.integer 'expires_in', null: false
    t.datetime 'revoked_at'
    t.string 'previous_refresh_token'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['access_token'], name: 'index_devise_api_tokens_on_access_token'
    t.index ['previous_refresh_token'], name: 'index_devise_api_tokens_on_previous_refresh_token'
    t.index ['refresh_token'], name: 'index_devise_api_tokens_on_refresh_token'
    t.index %w[resource_owner_type resource_owner_id], name: 'index_devise_api_tokens_on_resource_owner'
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_tags_on_name', unique: true
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'first_name'
    t.string 'last_name'
    t.boolean 'admin', default: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.integer 'failed_attempts', default: 0, null: false
    t.datetime 'locked_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'versions', force: :cascade do |t|
    t.string 'item_type', null: false
    t.bigint 'item_id', null: false
    t.string 'event', null: false
    t.string 'whodunnit'
    t.text 'object'
    t.datetime 'created_at'
    t.index %w[item_type item_id], name: 'index_versions_on_item_type_and_item_id'
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'articles', 'categories'
  add_foreign_key 'articles', 'users', column: 'author_id'
  add_foreign_key 'comment_votes', 'comments'
  add_foreign_key 'comment_votes', 'users'
  add_foreign_key 'comments', 'articles'
  add_foreign_key 'comments', 'users'
end
