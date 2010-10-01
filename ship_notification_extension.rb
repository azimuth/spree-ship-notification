# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ShipNotificationExtension < Spree::Extension
  version "1.0"
  description "Notify customer that order has shipped."
  url "http://github.com/azimuth/spree-ship-notification"
  
  def activate
    OrderMailer.class_eval do
      def shipped(order, resend = false)
        @subject    = (resend ? "[RESEND] " : "") 
        @subject    += Spree::Config[:site_name] + ' ' + 'Order Delivery #' + order.number
        @body       = {"order" => order}
        @recipients = order.email
        @from       = Spree::Config[:order_from]
        @bcc        = order_bcc
        @sent_on    = Time.now
        
        order.ship_notified = true
        order.save
      end
    end

    Order.class_eval do
      attr_accessor :ship_notified
      
      def ship_notification_sent?
        @ship_notified
      end
    end
    
    @order_observer = OrderObserver.instance
    
  end
end
