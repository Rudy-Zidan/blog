class CreatePostService < ApplicationService
  def initialize(title:, description:, content:, author:)
    @title = title
    @description = description
    @content = content
    @author = author
  end

  def run
    post = Post.new(
       title: @title,
       description: @description,
       content: @content,
       author: @author
    )

    post.save
    if post.errors.empty?
      presented = PostPresenter.new(post: post).present
      broadcast("post", { post:  presented })
    end

    post
  end
end