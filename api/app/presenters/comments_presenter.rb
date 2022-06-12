class CommentsPresenter < ApplicationPresenter
  def initialize(comments:)
    @comments = comments
  end

  def present
    @comments.map do |comment|
      CommentPresenter.new(comment: comment).present
    end
  end
end