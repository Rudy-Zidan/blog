class UpdatePostService < ApplicationService
  def initialize(post:, params:)
    @post = post
    @params = params
  end

  def run
    if @post.author_id != @params[:author_id]
      @post.errors.add(:author, "not authorized for this action")
      return @post
    end

    @post.update(@params)
    if @post.errors.empty?
      presented = PostPresenter.new(post: @post).present
      broadcast("post_update", { post: presented })
    end

    @post
  end
end