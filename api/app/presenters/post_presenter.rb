class PostPresenter < ApplicationPresenter
  def initialize(post:)
    @post = post
  end

  def present
    {
      id: @post.id,
      author: AuthorPresenter.new(author: @post.author).present,
      title: @post.title,
      description: @post.description,
      content: @post.content,
      published: @post.published?,
      updated_at: @post.updated_at
    }
  end
end