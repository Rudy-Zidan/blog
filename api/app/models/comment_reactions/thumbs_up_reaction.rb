module CommentReactions
  class ThumbsUpReaction < CommentReaction
    belongs_to :comment, counter_cache: true
  end
end