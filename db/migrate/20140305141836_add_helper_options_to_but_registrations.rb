class AddHelperOptionsToButRegistrations < ActiveRecord::Migration
  def change
    remove_column :but_registrations, :wants_to_help, :boolean

    add_column    :but_registrations, :wants_to_help_checkin, :boolean, default: false
    add_column    :but_registrations, :wants_to_help_freestyler, :boolean, default: false
    add_column    :but_registrations, :wants_to_help_party, :boolean, default: false
    add_column    :but_registrations, :wants_to_help_kiosk, :boolean, default: false
  end
end
