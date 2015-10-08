class AddVisibleToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :visible, :boolean, default: false
  end
end
