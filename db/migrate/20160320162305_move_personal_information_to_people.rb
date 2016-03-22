class MovePersonalInformationToPeople < ActiveRecord::Migration
  def change
    add_column :people, :gender, :integer, default: 0, null: false
    remove_column :conference_registrations, :sex
  end
end
