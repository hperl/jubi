class AddDescriptionToTimeslots < ActiveRecord::Migration
  def change
    add_column :timeslots, :description, :text
  end
end
