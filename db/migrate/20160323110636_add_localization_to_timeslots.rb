class AddLocalizationToTimeslots < ActiveRecord::Migration
  def change
    remove_column :timeslots, :name
    remove_column :timeslots, :description

    add_column :timeslots, :name_de, :string, default: "", null: false
    add_column :timeslots, :name_en, :string, default: "", null: false
    add_column :timeslots, :description_de, :string, default: "", null: false
    add_column :timeslots, :description_en, :string, default: "", null: false
  end
end
