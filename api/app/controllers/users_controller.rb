class UsersController < ApplicationController
  before_action :get_author, only: :posts

  def index
    users = GetAllUsersService.new.run
    
    presented = ::UsersPresenter.new(users: users).present
    render json: presented, status: :ok
  end

  def create
    user = ::CreateUserService.new(**build_create_params).run
    return present_errors(user.errors) if user.errors.any?
    
    presented = ::UserPresenter.new(user: user).present
    render json: presented, status: :created
  end

  def posts
    return present_not_found_resource(Author) unless @author

    posts = GetPostsByAuthorService.new(author: @author).run
    presented = ::PostsPresenter.new(posts: posts).present
    render json: presented, status: :ok
  end

  private

  def create_params
    params.permit(:name, :email)
  end

  def build_create_params
    {
      name: create_params[:name],
      email: create_params[:email]
    }
  end
end
