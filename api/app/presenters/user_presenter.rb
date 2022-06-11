class UserPresenter < ApplicationPresenter
  def initialize(user:)
    @user = user
  end

  def present
    {
      id: @user.id,
      name: @user.name,
      email: @user.email,
    }
  end
end