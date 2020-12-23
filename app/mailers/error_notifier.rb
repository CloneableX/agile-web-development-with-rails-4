class ErrorNotifier < ApplicationMailer
  default from: 'Sam Ruby <depot@example.com>', to: 'admin@example.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.error_notifier.report.subject
  #
  def report(exception)
    @exception = exception

    mail subject: 'Depot Error Report'
  end
end
