class CreateUserService < ApplicationService
  def initialize(name:, email:)
    @name = name
    @email = email
  end

  def run
    user = User.new(name: @name, email: @email)
    user.save
    user
  end
end