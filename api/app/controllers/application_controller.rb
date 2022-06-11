class ApplicationController < ActionController::API
  private

  def present_errors(errors)
    presented = ::ValidationErrorsPresenter.new(errors: errors).present
    render json: presented, status: :bad_request
  end
end
