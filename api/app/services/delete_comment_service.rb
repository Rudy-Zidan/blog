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
    @comment
  end
end