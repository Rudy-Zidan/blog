module CommentReactions
  class SmileReaction < CommentReaction
    belongs_to :comment, counter_cache: true
  end
end