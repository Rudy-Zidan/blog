class PostsController < ApplicationController
  before_action :get_post, only: %i(show update destroy comments)
  before_action :get_author, only: :create

  def index
    posts = GetAllPostsService.new.run
    presented = PostsPresenter.new(posts: posts).present
    render json: presented, status: :ok
  end

  def create
    return present_not_found_resource(Author) unless @author

    post = CreatePostService.new(**build_create_params).run
    return present_errors(post.errors) if post.errors.any?

    presented = PostPresenter.new(post: post).present
    render json: presented, status: :created
  end

  def show
    return present_not_found_resource(Post) unless @post

    presented = PostPresenter.new(post: @post).present
    render json: presented, status: :ok
  end

  def update
    return present_not_found_resource(Post) unless @post

    @post = UpdatePostService.new(post: @post, params: build_update_params).run
    return present_errors(@post.errors) if @post.errors.any?

    presented = PostPresenter.new(post: @post).present
    render json: presented, status: :ok
  end

  def destroy
    return present_not_found_resource(Post) unless @post

    @post = DeletePostService.new(post: @post, params: build_delete_params).run
    return present_errors(@post.errors) if @post.errors.any?

    presented = PostPresenter.new(post: @post).present
    render json: presented, status: :ok
  end

  def comments
    return present_not_found_resource(Post) unless @post

    comments = GetCommentsByPostService.new(post: @post).run
    presented = CommentsPresenter.new(comments: comments).present
    render json: presented, status: :ok
  end

  private

  def post_params
    params.permit(:title, :description, :content, :author_id, :published)
  end

  def build_create_params
    {
      author: @author,
      title: post_params[:title],
      description: post_params[:description],
      content: post_params[:content],
    }
  end

  def build_update_params
    {
      author_id: post_params.dig(:author_id)&.to_i,
      title: post_params[:title],
      description: post_params[:description],
      content: post_params[:content],
      published: post_params[:published]
    }
  end

  def build_delete_params
    {
      author_id: post_params.dig(:author_id)&.to_i,
    }
  end

  def get_post
    @post = Post.find_by(id: params[:id])
  end
end
