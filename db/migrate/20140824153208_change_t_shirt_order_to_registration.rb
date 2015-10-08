class ChangeTShirtOrderToRegistration < ActiveRecord::Migration
  def change
    remove_column :but_registrations, :t_shirt_amount, :integer
    reversible do |dir|
      change_table :but_registrations do |t|
        dir.up   { t.change :t_shirt_size, :string }
        dir.down { t.change :t_shirt_size, :integer }
      end
    end
  end
end
