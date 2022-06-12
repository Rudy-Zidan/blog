class Post < ApplicationRecord
  belongs_to :author, foreign_key: :user_id
  has_many :comments, dependent: :delete_all

  validates :title, :description, :content, presence: true

  alias_attribute :author_id, :user_id
end
