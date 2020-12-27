require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "should exchange currency amount by locale" do
    I18n.locale = 'es'
    assert_equal number_to_currency(82), localized_currency(100)
  end

  test "should not exchange when locale is default_locale" do
    I18n.locale = I18n.default_locale
    assert_equal number_to_currency(100), localized_currency(100)
  end
end