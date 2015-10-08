class AddTrainerToWorkshopChoice < ActiveRecord::Migration
  def change
    add_column :workshop_choices, :trainer, :boolean, defaut: false
  end
end
