class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.text :name
      t.string :role
      t.text :password_digest
      t.timestamps
    end
  end
end
