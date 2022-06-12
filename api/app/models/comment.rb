class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true

  delegate :name, to: :user, prefix: :user
end
