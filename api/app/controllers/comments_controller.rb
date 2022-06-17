class CommentsController < ApplicationController
  before_action :get_comment, only: %i(update destroy)
  before_action :get_comment_reaction, only: :delete_reactions

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

    presented = CommentPresenter.new(comment: @comment).present
    render json: presented, status: :ok
  end

  def destroy
    return present_not_found_resource(Comment) unless @comment

    @post = DeleteCommentService.new(comment: @comment, params: build_delete_params).run
    return present_errors(@comment.errors) if @comment.errors.any?

    presented = CommentPresenter.new(comment: @comment).present
    render json: presented, status: :ok
  end

  def reactions
    @comment = CreateCommentReactionService.new(**build_reaction_params).run
    return present_errors(@comment.errors) if @comment.errors.any?

    presented = CommentReactionPresenter.new(comment_reaction: @comment).present
    render json: presented, status: :created
  end

  def delete_reactions
    return present_not_found_resource(CommentReaction) unless @comment_reaction

    @comment_reaction = DeleteCommentReactionService.new(comment_reaction: @comment_reaction, params: build_delete_reaction_params).run
    return present_errors(@comment_reaction.errors) if @comment_reaction.errors.any?

    presented = CommentReactionPresenter.new(comment_reaction: @comment_reaction).present
    render json: presented, status: :ok
  end

  private

  def comment_params
    params.permit(:id, :post_id, :user_id, :content)
  end

  def comment_reaction_params
    params.permit(:id, :reaction_id, :user_id, :reaction)
  end

  def build_params
    {
      post_id: comment_params.dig(:post_id)&.to_i,
      user_id: comment_params.dig(:user_id)&.to_i,
      content: comment_params[:content],
    }
  end

  def build_delete_params
    {
      user_id: comment_params.dig(:user_id)&.to_i,
    }
  end

  def build_reaction_params
    {
      comment_id: comment_reaction_params.dig(:id)&.to_i,
      user_id: comment_reaction_params.dig(:user_id)&.to_i,
      reaction: comment_reaction_params[:reaction]
    }
  end

  def build_delete_reaction_params
    {
      user_id: comment_reaction_params.dig(:user_id)&.to_i,
    }
  end

  def get_comment
    @comment = Comment.find_by(id: comment_params[:id])
  end

  def get_comment_reaction
    @comment_reaction = CommentReaction.find_by(id: comment_reaction_params[:reaction_id])
  end
end
