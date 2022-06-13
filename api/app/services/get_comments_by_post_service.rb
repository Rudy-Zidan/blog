class GetCommentsByPostService < ApplicationService
  def initialize(post:)
    @post = post
  end

  def run
    return Comment.none unless @post

    @post.comments.includes(:user, :comment_reactions)
  end
end