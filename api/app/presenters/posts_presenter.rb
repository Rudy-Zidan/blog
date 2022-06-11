class PostsPresenter < ApplicationPresenter
  def initialize(posts:)
    @posts = posts
  end

  def present
    @posts.map do |post|
      PostPresenter.new(post: post).present
    end
  end
end