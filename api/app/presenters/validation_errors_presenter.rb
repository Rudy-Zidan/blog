class ValidationErrorsPresenter < ApplicationPresenter
  def initialize(errors:)
    @errors = errors
  end

  def present
    {
      errors: @errors.map do |error|
        {
          field: error.attribute,
          message: error.message
        }
      end
    }
  end
end