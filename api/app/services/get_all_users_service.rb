class GetAllUsersService < ApplicationService
  def run
    User.all
  end
end