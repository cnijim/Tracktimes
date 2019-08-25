class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.integer :user_id
      t.integer :year
      t.string :make
      t.string :model
      t.timestamps
    end
    add_index :vehicles, :user_id
  end
end
