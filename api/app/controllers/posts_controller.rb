class PostsController < ApplicationController
  before_action :get_post, only: :show

  def show
    return present_not_found_resource(Post) unless @post

    presented = ::PostPresenter.new(post: @post).present
    render json: presented, status: :ok
  end

  private

  def get_post
    @post = Post.find_by(id: params[:id])
  end
end
