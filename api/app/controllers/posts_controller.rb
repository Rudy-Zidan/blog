class PostsController < ApplicationController
  before_action :get_post, only: :show
  before_action :get_author, only: :create

  def create
    return present_not_found_resource(Author) unless @author

    post = CreatePostService.new(**build_create_params).run
    return present_errors(post.errors) if post.errors.any?

    presented = ::PostPresenter.new(post: post).present
    render json: presented, status: :created
  end

  def show
    return present_not_found_resource(Post) unless @post

    presented = ::PostPresenter.new(post: @post).present
    render json: presented, status: :ok
  end

  private

  def create_params
    params.permit(:title, :description, :content, :author_id)
  end

  def build_create_params
    {
      author: @author,
      title: create_params[:title],
      description: create_params[:description],
      content: create_params[:content],
    }
  end

  def get_post
    @post = Post.find_by(id: params[:id])
  end
end
