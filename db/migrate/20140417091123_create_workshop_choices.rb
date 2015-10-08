class CreateWorkshopChoices < ActiveRecord::Migration
  def change
    create_table :workshop_choices do |t|
      t.integer :but_registration_id
      t.integer :workshop_id
      t.integer :choice_type, default: 1
      t.boolean :final,       default: false

      t.timestamps
    end
  end
end
