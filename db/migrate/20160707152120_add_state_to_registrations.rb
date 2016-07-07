class AddStateToRegistrations < ActiveRecord::Migration
  def change
    add_column :conference_registrations, :state, :integer, default: 0, null: false
    add_column :party_registrations, :state, :integer, default: 0, null: false
  end
end
