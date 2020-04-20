class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, :id => false do |t|
      t.integer :id
      t.text :name
      t.string :role
      t.timestamps
    end
  end
end
