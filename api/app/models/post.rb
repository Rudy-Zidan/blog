class Post < ApplicationRecord
  belongs_to :author, foreign_key: :user_id

  validates :title, :description, :content, presence: true

  alias_attribute :author_id, :user_id
end
