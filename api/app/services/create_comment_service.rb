class CreateCommentService < ApplicationService
  def initialize(post_id:, user_id:, content:)
    @post_id = post_id
    @user_id = user_id
    @content = content
  end

  def run
    comment = Comment.new(
      post_id: @post_id, 
      user_id: @user_id, 
      content: @content
    )

    comment.save
    if comment.errors.empty?
      presented = CommentPresenter.new(comment: comment).present
      broadcast("post_comments_#{@post_id}", { comment: presented })
    end

    comment
  end
end