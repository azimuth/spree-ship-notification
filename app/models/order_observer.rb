class OrderObserver < ActiveRecord::Observer
  observe Order
  def after_save(record)
    if record.state == 'shipped' and not record.ship_notification_sent?
      OrderMailer.deliver_shipped(record)
    end
  end
end