class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item

  def self.rate_menu_items(rating)
    ids = all.map { |order_item| order_item.menu_item_id }.uniq
    ids.each do |id|
      if MenuItem.where("id = ?", id).exists?
        menu_item = MenuItem.find(id)
        menu_item.no_of_ratings = menu_item.no_of_ratings + 1
        menu_item.save!
        menu_item.ratings = (menu_item.ratings.to_f + rating.to_i) / (menu_item.no_of_ratings)
        menu_item.save!
      else
      end
    end
  end

  def self.get_order_item(menu_item_id)
    where("menu_item_id = ?", menu_item_id)
  end

  def to_a_string
    "#{id} #{order_id} #{menu_item_id} #{menu_item_name} #{menu_item_price}"
  end

  def self.destroy_wrong_items(id)
    all.each do |order_item|
      order = Order.find(order_item.order_id)
      if order.status = "being_created" && order_item.menu_item_id == id
        order_item.destroy
      end
    end
  end

  def self.get_menu_item_price(menu_item_name)
    find_by(menu_item_name: menu_item_name).menu_item_price
  end
end
