class AddMaxTnToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :max_tn, :integer
  end
end
