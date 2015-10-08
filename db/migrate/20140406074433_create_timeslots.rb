class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.string   :name
      t.integer  :kind
      t.datetime :start
      t.datetime :end
    end

    create_table :timeslots_workshops do |t|
      t.integer :timeslot_id
      t.integer :workshop_id
    end
  end
end
