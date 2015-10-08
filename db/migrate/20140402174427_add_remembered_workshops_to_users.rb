class AddRememberedWorkshopsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remembered_workshop_ids, :text
  end
end
