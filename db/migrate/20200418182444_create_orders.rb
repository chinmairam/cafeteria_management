class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.date :date
      t.integer :user_id
      t.integer :feedback
      t.text :address
      t.datetime :delivered_at
      t.datetime :ordered_at
      t.text :status
      t.timestamps
    end
  end
end
