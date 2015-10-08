class AddHelperShiftToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :helper_shift, :boolean, default: false
  end
end
