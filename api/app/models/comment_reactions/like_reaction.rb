module CommentReactions
  class LikeReaction < CommentReaction
    belongs_to :comment, counter_cache: true
  end
end