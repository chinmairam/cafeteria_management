class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus, :id => false do |t|
      t.integer :id
      t.text :name
    end
  end
end
