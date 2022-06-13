class CommentReactionPresenter < ApplicationPresenter
  def initialize(comment_reaction:)
    @comment_reaction = comment_reaction
    @reaction = reaction
  end

  def present
    {
      id: @comment_reaction.id,
      comment_id: @comment_reaction.comment_id,
      user_id: @comment_reaction.user_id,
      reaction: reaction
    }
  end

  private

  def reaction
    reaction_name = @comment_reaction.type.split('::').last
    reaction_name.gsub("Reaction", "").downcase
  end
end