class ChangeWorkshops < ActiveRecord::Migration
  def change
    rename_column :workshops, :location_requirements, :special_requirements
  end
end
