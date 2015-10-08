class AddExtendedKernteamToButRegistration < ActiveRecord::Migration
  def change
    add_column :users, :extended_kernteam, :boolean, default: false, null: false
  end
end
