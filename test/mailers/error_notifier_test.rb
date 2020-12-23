require 'test_helper'

class ErrorNotifierTest < ActionMailer::TestCase
  test "report" do
    mail = ErrorNotifier.report(StandardError.new)
    assert_equal "Depot Error Report", mail.subject
    assert_equal ["admin@example.com"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /StandardError/, mail.body.encoded
  end

end
