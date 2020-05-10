class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :user
  validates :address, presence: true

  def to_a_string
    "#{id} #{date} Items:#{order_items.map { |item| item.menu_item_name }.join("---")} TOTAL PRICE:#{total_price} STATUS:#{status} #{delivered_at}"
  end

  def self.delivered
    where.not("status = ? ", "being_created")
  end

  def self.pending_orders
    where("status= ?", "order_confirmed")
  end

  def self.being_created
    where("status= ?", "being_created").first
  end

  def to_a_string
    "#{id} #{order_id} #{menu_item_id} #{menu_item_name} #{menu_item_price}"
  end

  def order_item(menu_item_name)
    order_items.where(menu_item_name: menu_item_name).first
  end

  def get_number_of_items(order_item)
    order_items.where(id: order_item.id).count
  end

  def all_menu_item_names
    order_items.order(:menu_item_name).map { |item| item.menu_item_name }
  end

  def self.get_order_by_id(id)
    order = all.where("id = ?", id).exists? ? find(id) : false
  end

  def walkin_order?
    user = User.find(user_id)
    if user.is_owner? || user.is_clerk?
      true
    else
      false
    end
  end

  def self.completed
    where("status = ? ", "order_delivered")
  end

  def self.destroy_wrong_items(id)
    all.each do |order_item|
      order.order_items.all.each do |order_item|
        if order_item.menu_item_id == id
          order_item.destroy
        end
      end
    end
  end

  def order_status
    if status == "being_created"
      "Being Created"
    elsif status == "order_confirmed"
      "order confirmed"
    else
      "Delivered at #{delivered_at.strftime("%d %B,%Y - %I:%M %p")}"
    end
  end

  def total_price
    price = 0
    order_items.each { |item| price = price + item.menu_item_price }
    price
  end
end
