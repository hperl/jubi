class AddHabtmToButRegistrationsAndTimeslots < ActiveRecord::Migration
  def change
    create_table :but_registrations_timeslots, id: false do |t|
      t.belongs_to :but_registration, index: true
      t.belongs_to :timeslot, index: true
    end
  end
end
