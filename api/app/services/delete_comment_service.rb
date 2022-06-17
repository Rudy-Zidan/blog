class DeleteCommentService < ApplicationService
  def initialize(comment:, params:)
    @comment = comment
    @params = params
  end

  def run
    if @comment.user_id != @params[:user_id]
      @comment.errors.add(:user, "not authorized for this action")
      return @comment
    end

    @comment.destroy
    if @comment.errors.empty?
      presented = CommentPresenter.new(comment: @comment).present
      broadcast("post_comment_delete_#{@comment.post_id}", { comment: presented })
    end

    @comment
  end
end