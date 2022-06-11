class CreateUserService < ApplicationService
  def initialize(name:, email:)
    @name = name
    @email = email
  end

  def run
    User.create!(name: @name, email: @email)
  end
end