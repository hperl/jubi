class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :amount_in_cents, default: 0
      t.belongs_to :user
      t.belongs_to :responsible_user
      t.timestamps
    end
  end
end
