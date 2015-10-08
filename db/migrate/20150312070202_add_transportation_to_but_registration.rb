class AddTransportationToButRegistration < ActiveRecord::Migration
  def change
    add_column :but_registrations, :transportation, :integer, null: false, default: 0
  end
end
