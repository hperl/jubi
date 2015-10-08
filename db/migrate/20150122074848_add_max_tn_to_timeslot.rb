class AddMaxTnToTimeslot < ActiveRecord::Migration
  def change
    add_column :timeslots, :max_tn, :integer
  end
end
