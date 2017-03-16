require 'date'
require './src/invoice_notification_sender_service'

module InvoiceReminderService
  def self.process(invoice, date = Date.today)
    # do smth with invoice
  end
end
