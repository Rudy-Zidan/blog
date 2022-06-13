class DeleteCommentReactionService < ApplicationService
  def initialize(comment_reaction:, params:)
    @comment_reaction = comment_reaction
    @params = params
  end

  def run
    return unless @comment_reaction

    if @comment_reaction.user_id != @params[:user_id]
      @comment_reaction.errors.add(:user, "not authorized for this action")
      return @comment_reaction
    end
  
    @comment_reaction.destroy
    @comment_reaction
  end
end