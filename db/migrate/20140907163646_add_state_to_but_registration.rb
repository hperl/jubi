class AddStateToButRegistration < ActiveRecord::Migration
  def change
    add_column :but_registrations, :state, :integer, default: 0
  end
end
