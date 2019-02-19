class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  validates :title,       presence: true, length: {minimum: 3,  maximum: 50}
  validates :description, presence: true, length: {minimum: 10, maximum: 10000}
  validates :user_id, presence: true

  # after_commit do |record|
  #  client = Search.client
  #  document = record.as_json(only: [:id, :title, :description, :user_id])
  #
  #  client.index_document(Search::ENGINE_NAME, document)
  # end
  #
  # after_destroy do |record|
  #   client = Search.client
  #   document = record.as_json(only: [:id])
  #
  #   client.destroy_documents(Search::ENGINE_NAME, [ document[:id] ])
  # end
end
