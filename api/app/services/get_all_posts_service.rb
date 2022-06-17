class GetAllPostsService < ApplicationService
  def run
    Post.all.includes(:author).order(id: :desc)
  end
end