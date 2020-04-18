class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders, :id => false do |t|
      t.integer :id
      t.date :date
      t.integer :user_id
    end
  end
end
