class OrdersItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :menu_item

  def self.get_menu_item_price(menu_item_name)
    find_by(menu_item_name: menu_item_name).menu_item_price
  end


  def all_menu_item_names
    order_items.order(:menu_item_name).map { |item| item.menu_item_name }
  end
  
end
