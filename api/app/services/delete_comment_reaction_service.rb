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
    if @comment_reaction.errors.empty?
      presented = CommentReactionPresenter.new(comment_reaction: @comment_reaction).present
      broadcast("delete_reaction", { reaction: presented })
    end

    @comment_reaction
  end
end