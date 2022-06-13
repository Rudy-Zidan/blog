class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # DB foreign_key action on_delete cascade
  # prevents N+1 Queries, as the post will remove comment by comment using :destroy
  # it will trigger delete statement per each comment being destroyed.
  has_many :comment_reactions
  has_many :like_reactions, class_name: CommentReactions::LikeReaction.name
  has_many :smile_reactions, class_name: CommentReactions::SmileReaction.name
  has_many :thumbs_up_reactions, class_name: CommentReactions::ThumbsUpReaction.name

  validates :content, presence: true

  delegate :name, to: :user, prefix: :user
end
