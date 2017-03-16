require_relative './spec_helper'
require_relative '../src/invoice'

require_relative '../src/invoice_reminder_service'
require_relative '../src/invoice_notification_sender_service'

describe 'Service invoice reminder' do

  before(:suite) do
  end

  it "should send a notification 10 days before invoice issue" do
    invoice = Invoice.new('12EDF432', 2300, Date.parse('2017-02-15'), nil,
                          'Doe', 'John', 'john.doe@example.com')

    InvoiceReminderService.process(invoice, Date.parse('2017-02-25'))
    expect(InvoiceNotificationSenderService).to(
      receive(:send_before_due_date_notification).with(invoice)
    )
  end

end