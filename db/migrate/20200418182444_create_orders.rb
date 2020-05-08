class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.date :date
      t.integer :user_id
      t.text :address
      t.integer :ratings, default: 0
      t.datetime :delivered_at
      t.datetime :ordered_at
      t.string :status, default: "being_created"

      t.timestamps
    end
  end
end
