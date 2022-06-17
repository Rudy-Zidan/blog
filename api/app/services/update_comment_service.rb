class UpdateCommentService < ApplicationService
  def initialize(comment:, params:)
    @comment = comment
    @params = params
  end

  def run
    if @comment.post_id != @params[:post_id] || @comment.user_id != @params[:user_id]
      @comment.errors.add(:comment, "the original post or the user are not allowed to be changed")
      return @comment
    end

    @comment.update(@params)
    if @comment.errors.empty?
      presented = CommentPresenter.new(comment: @comment).present
      broadcast("post_comment_update#{@comment.post_id}", { comment: presented })
    end

    @comment
  end
end