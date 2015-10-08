class AddMoreHelperOptions < ActiveRecord::Migration
  def change
    add_column :but_registrations, :wants_to_help_ersthelfer, :boolean, default: false
    add_column :but_registrations, :wants_to_help_grillen,    :boolean, default: false
    add_column :but_registrations, :sex,                      :integer, default: 2, null: false
    add_column :but_registrations, :age,                      :integer
  end
end
