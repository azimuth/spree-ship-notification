class AddShipNotificationToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :ship_notified, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :orders, :ship_notified
  end
end