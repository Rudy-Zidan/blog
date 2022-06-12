class CommentsController < ApplicationController
  def create
    comment = CreateCommentService.new(**build_create_params).run
    return present_errors(comment.errors) if comment.errors.any?

    presented = CommentPresenter.new(comment: comment).present
    render json: presented, status: :created
  end

  private

  def comment_params
    params.permit(:id, :post_id, :user_id, :content)
  end

  def build_create_params
    {
      post_id: comment_params[:post_id],
      user_id: comment_params[:user_id],
      content: comment_params[:content],
    }
  end
end
