class CreateConferenceRegistrations < ActiveRecord::Migration
  def change
    create_table :conference_registrations do |t|
      t.datetime :arrival, null: false
      t.datetime :departure, null: false
      t.integer :sex, null: false, default: 0
      t.integer :accomodation, null: false, default: 0
      t.integer :room_mates, null: false, default: 0
      t.integer :diet, null: false, default: 0
      t.text :diet_other, null: false, default: ""
      t.text :comment

      t.references :person
      t.references :user

      t.timestamps null: false
    end
  end
end
