class ApplicationController < ActionController::API
  private

  def present_errors(errors)
    presented = ::ValidationErrorsPresenter.new(errors: errors).present
    render json: presented, status: :bad_request
  end

  def get_user_by_id
    @user = User.find_by(id: params[:id])
  end

  def present_not_found_resource(resource)
    presented = ::NotFoundPresenter.new(resource: resource.name).present
    render json: presented, status: :not_found
  end
end
