class AddLgToButRegistration < ActiveRecord::Migration
  def change
    add_column :but_registrations, :lg, :integer, default: 0
  end
end
