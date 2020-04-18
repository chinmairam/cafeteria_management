class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items, :id => false do |t|
      t.integer :id
      t.integer :order_id
      t.integer :menu_item_id
      t.text :menu_item_name
      t.integer :menu_item_price
    end
  end
end
