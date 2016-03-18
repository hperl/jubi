class CreatePartyRegistrations < ActiveRecord::Migration
  def change
    create_table :party_registrations do |t|
      t.references :person
      t.references :user
      t.text :music_wishes

      t.timestamps null: false
    end
  end
end
