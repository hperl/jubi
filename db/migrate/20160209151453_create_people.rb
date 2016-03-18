class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.text :address, null: false
      t.string :nickname
      t.boolean :visible, null: false, default: false
      t.integer :age
      t.integer :lg, null: false, default: 0

      t.references :user, null: false

      t.timestamps null: false
    end
  end
end
