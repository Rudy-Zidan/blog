class NotFoundPresenter < ApplicationPresenter
  def initialize(resource:)
    @resource = resource
  end

  def present
    {
      resource: @resource,
      message: "Not found"
    }
  end
end