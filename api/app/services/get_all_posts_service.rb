class GetAllPostsService < ApplicationService
  def run
    Post.all.includes(:author)
  end
end