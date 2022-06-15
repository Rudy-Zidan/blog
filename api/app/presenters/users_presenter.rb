class UsersPresenter < ApplicationPresenter
  def initialize(users:)
    @users = users
  end

  def present
    @users.map do |user|
      UserPresenter.new(user: user).present
    end
  end
end