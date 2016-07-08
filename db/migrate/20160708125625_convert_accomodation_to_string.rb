class ConvertAccomodationToString < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :conference_registrations do |t|
        dir.up   { t.change :accomodation, :string, default: 'no_room' }
        dir.down { t.change :accomodation, :integer, default: 0 }
      end
    end
  end
end
