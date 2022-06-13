class CommentReaction < ApplicationRecord
  belongs_to :comment
  belongs_to :user

  validates :type, uniqueness: { scope: %i(comment_id user_id), message: "you already reacted in the same way before" }
end
