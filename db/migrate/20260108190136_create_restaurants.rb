class CreateRestaurants < ActiveRecord::Migration[8.0]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :owner_name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.text :address, null: false
      t.string :plan, null: false, default: "free"
      t.string :status, null: false, default: "pending"
      t.references :user, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
    
    add_index :restaurants, :status
    add_index :restaurants, :plan
    add_index :restaurants, :email
  end
end
