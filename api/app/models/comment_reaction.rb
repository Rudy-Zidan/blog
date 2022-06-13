class CommentReaction < ApplicationRecord
  belongs_to :comment
  belongs_to :user

  validates :type, uniqueness: { scope: %i(comment_id user_id), message: "you already reacted in the same way before" }

  def reactions
    {
      like: CommentReactions::LikeReaction,
      smile: CommentReactions::SmileReaction,
      thumbs_up: CommentReactions::ThumbsUpReaction,
    }
  end
end
