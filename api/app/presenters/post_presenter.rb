class PostPresenter < ApplicationPresenter
  def initialize(post:)
    @post = post
  end

  def present
    {
      id: @post.id,
      author_id: @post.author_id,
      title: @post.title,
      description: @post.description,
      content: @post.content,
      published: @post.published?
    }
  end
end