require 'test_helper'

class LoaderTest < ActiveSupport::TestCase
  self.test_order = :alpha

  # When the order of tests change, the lookup of LoginService is changed.
  #
  # If ::LoginService is not yet loaded, the unqualified LoginService reference
  # from WebApi::PasswordResetService will load WebApi::LoginService, as expected.
  #
  # However, if the order of these tests are changed, and ::LoginService is loaded
  # before WebApi::PasswordResetService looks up the unqualified LoginService reference,
  # it will find the global ::LoginService and not attempt to look on ::WebApi.

  test "A) when global service not preloaded it calls the correct LoginService" do
    ::WebApi::PasswordResetService.call

    assert ::WebApi::LoginService.called?, "::WebApi::LoginService not called when it should be called"
    assert_not ::Api::LoginService.called?, "::Api::LoginService called when it should not be called"
    assert_not ::LoginService.called?, "::LoginService called when it should not be called"
  end

  test "B) when global service preloaded it calls the correct LoginService" do
    # Touch the global LoginService to ensure it's been loaded
    ::LoginService.called?

    ::WebApi::PasswordResetService.call

    assert ::WebApi::LoginService.called?, "::WebApi::LoginService not called when it should be called"
    assert_not ::Api::LoginService.called?, "::Api::LoginService called when it should not be called"
    assert_not ::LoginService.called?, "::LoginService called when it should not be called"
  end
end
