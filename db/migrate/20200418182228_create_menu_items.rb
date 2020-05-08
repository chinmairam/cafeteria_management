class CreateMenuItems < ActiveRecord::Migration[6.0]
  def change
    create_table :menu_items do |t|
      t.integer :menu_id
      t.text :name
      t.text :description
      t.integer :price
      t.boolean :active
      t.decimal :ratings, precision: 2, scale: 1, default: "0.0"
      t.integer :no_of_ratings, default: 0
      t.timestamps
    end
  end
end
