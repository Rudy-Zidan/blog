class User < ApplicationRecord
  has_many :posts

  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
