class RenameRegistrationsTable < ActiveRecord::Migration
  def change
    rename_table(:registrations, :but_registrations)
  end
end
