class CreateCommentReactionService < ApplicationService
  def initialize(comment_id:, user_id:, reaction:)
    @comment_id = comment_id
    @user_id = user_id
    @reaction = reaction
  end

  def run
    comment_reaction_klass = CommentReaction.reactions[@reaction&.to_sym]

    unless comment_reaction_klass
      comment_reaction = CommentReaction.new
      comment_reaction.errors.add(:reaction, "invalid reaction, should be (like or smile or thumbs_up)")
      return comment_reaction
    end
  
    comment_reaction = comment_reaction_klass.new(comment_id: @comment_id, user_id: @user_id)
    comment_reaction.save
    comment_reaction
  end
end