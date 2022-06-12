class CommentsController < ApplicationController
  before_action :get_comment, only: :update

  def create
    comment = CreateCommentService.new(**build_params).run
    return present_errors(comment.errors) if comment.errors.any?

    presented = CommentPresenter.new(comment: comment).present
    render json: presented, status: :created
  end

  def update
    return present_not_found_resource(Comment) unless @comment

    @post = UpdateCommentService.new(comment: @comment, params: build_params).run
    return present_errors(@comment.errors) if @comment.errors.any?

    presented = ::CommentPresenter.new(comment: @comment).present
    render json: presented, status: :ok
  end

  private

  def comment_params
    params.permit(:id, :post_id, :user_id, :content)
  end

  def build_params
    {
      post_id: comment_params.dig(:post_id)&.to_i,
      user_id: comment_params.dig(:user_id)&.to_i,
      content: comment_params[:content],
    }
  end

  def get_comment
    @comment = Comment.find_by(id: comment_params[:id])
  end
end
