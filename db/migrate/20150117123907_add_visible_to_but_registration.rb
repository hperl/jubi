class AddVisibleToButRegistration < ActiveRecord::Migration
  def change
    add_column :but_registrations, :visible, :boolean, default: false
  end
end
