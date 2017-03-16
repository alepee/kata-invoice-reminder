require_relative './spec_helper'
require_relative '../src/invoice'

require_relative '../src/invoice_reminder_service'
require_relative '../src/invoice_notification_sender_service'

describe 'Service invoice reminder' do
  it "should send a notification 10 days before invoice issue" do
    invoice = Invoice.new('12EDF432', 2300, Date.parse('2017-02-15'), nil,
                          'Doe', 'John', 'john.doe@example.com')
    expect(InvoiceNotificationSenderService).to(
        receive(:send_before_due_date_notification).with(invoice)
    )
    InvoiceReminderService.process(invoice, Date.parse('2017-02-25'))
  end

  it "should send a dunning_notification one month after due date" do
    invoice = Invoice.new('12EDF432', 2300, Date.parse('2017-02-15'), nil,
                          'Doe', 'John', 'john.doe@example.com')
    expect(InvoiceNotificationSenderService).to(
        receive(:send_dunning_notification).with(invoice)
    )
    InvoiceReminderService.process(invoice, Date.parse('2017-03-15'))
  end

  it "should send a dunning notification one month after due date at the end of the month" do
    invoice = Invoice.new('12EDF432', 2300, Date.parse('2017-01-31'), nil,
                          'Doe', 'John', 'john.doe@example.com')
    expect(InvoiceNotificationSenderService).to(
      receive(:send_dunning_notification).with(invoice)
    )
    InvoiceReminderService.process(invoice, Date.parse('2017-02-28'))
  end

  it "should send a dunning notification each month after due date" do
    invoice = Invoice.new('12EDF432', 2300, Date.parse('2017-01-31'), nil,
                          'Doe', 'John', 'john.doe@example.com')

    expect(InvoiceNotificationSenderService).to(
      receive(:send_dunning_notification).with(invoice)
    )
    InvoiceReminderService.process(invoice, Date.parse('2017-03-31'))
  end
end
