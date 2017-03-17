require 'date'
require 'active_support/core_ext/date'
require 'active_support/core_ext/integer'
require './src/invoice_notification_sender_service'

module InvoiceReminderService
  def self.process(invoice, date = Date.today)
    if (date - invoice.due_date).to_i == 10
      InvoiceNotificationSenderService.send_before_due_date_notification(invoice)
    end

    diff_in_months =
      (date.year * 12 + date.month) -
      (invoice.due_date.year * 12 + invoice.due_date.month)


    if diff_in_months > 0 and invoice.due_date + diff_in_months.months == date
      InvoiceNotificationSenderService.send_dunning_notification(invoice)
    end

    # if (invoice.due_date + 1.month) == date
    #   InvoiceNotificationSenderService.send_dunning_notification(invoice)
    # end
  end
end
