class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # DB foreign_key action on_delete cascade
  # prevents N+1 Queries, as the post will remove comment by comment using :destroy
  # it will trigger delete statement per each comment being destroyed.
  has_many :comment_reactions

  validates :content, presence: true

  delegate :name, to: :user, prefix: :user
end
