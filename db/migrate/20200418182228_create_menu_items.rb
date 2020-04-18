class CreateMenuItems < ActiveRecord::Migration[6.0]
  def change
    create_table :menu_items, :id => false do |t|
      t.integer :id
      t.integer :menu_id
      t.text :name
      t.text :description
      t.integer :price
    end
  end
end
