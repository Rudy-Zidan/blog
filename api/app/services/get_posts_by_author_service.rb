class GetPostsByAuthorService < ApplicationService
  def initialize(author:)
    @author = author
  end

  def run
    return Post.none unless @author

    @author.posts.includes(:author).order(id: :desc)
  end
end