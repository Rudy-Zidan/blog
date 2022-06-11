class UsersController < ApplicationController
  before_action :get_user_by_id, only: :posts

  def create
    user = ::CreateUserService.new(**build_create_params).run
    return present_errors(user.errors) if user.errors.any?
    
    presented = ::UserPresenter.new(user: user).present
    render json: presented, status: :created
  end

  def posts
    unless @user
      presented = ::NotFoundPresenter.new(resource: User.name).present
      return render json: presented, status: :not_found
    end

    posts = GetPostsByAuthorService.new(author: @user).run
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
