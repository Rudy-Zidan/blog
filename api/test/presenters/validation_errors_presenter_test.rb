require "test_helper"

class ValidationErrorsPresenterTest < ActiveSupport::TestCase
  test "present" do
    user = User.new
    user.valid?
    presenter = ValidationErrorsPresenter.new(errors: user.errors)
    errors_hash = presenter.present

    assert_equal(%i(errors), errors_hash.keys)
    assert_equal(:name, errors_hash[:errors][0][:field])
    assert_equal(:email, errors_hash[:errors][1][:field])
  end
end