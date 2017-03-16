require 'date'

class Invoice
  attr_reader(:reference)
  attr_reader(:price)
  attr_reader(:due_date)
  attr_reader(:payment_date)
  attr_reader(:contact_last_name)
  attr_reader(:contact_first_name)
  attr_reader(:contact_email)

  def initialize(reference, price, due_date, payment_date,
                 contact_last_name, contact_first_name, contact_email)

    raise TypeError.new unless due_date.class == Date
    raise TypeError.new unless payment_date.class == Date || payment_date.class == NilClass
    raise TypeError.new unless price.class == Integer

    @reference = reference
    @price = price
    @due_date = due_date
    @payment_date = payment_date
    @contact_last_name = contact_last_name
    @contact_first_name = contact_first_name
    @contact_email = contact_email
  end
end
