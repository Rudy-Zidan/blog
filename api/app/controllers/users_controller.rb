class UsersController < ApplicationController
  def create
    user = ::CreateUserService.new(**build_create_params).run
    return present_errors(user.errors) if user.errors.any?
    
    presented = ::UserPresenter.new(user: user).present
    render json: presented, status: :created
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
