class AddTShirtOrderToRegistration < ActiveRecord::Migration
  def change
    add_column :but_registrations, :t_shirt_amount, :integer, default: 0, null: false
    add_column :but_registrations, :t_shirt_size,   :integer, default: 0, null: false
  end
end
