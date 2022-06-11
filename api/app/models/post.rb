class Post < ApplicationRecord
  belongs_to :author, class_name: User.name, foreign_key: :user_id

  validates :title, :description, :content, presence: true
end
