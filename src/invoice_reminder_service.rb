require 'date'
require './src/invoice_notification_sender_service'

module InvoiceReminderService
  def self.process(invoice, date = Date.today)
    # do smth with invoice
    if (date - invoice.due_date).to_i == 10
      InvoiceNotificationSenderService.send_before_due_date_notification(invoice)
    end
  end
end
