class AddMealOptionsToAnmeldungen < ActiveRecord::Migration
  def change
    add_column :but_registrations, :diet,       :integer, default: 0
    add_column :but_registrations, :diet_other, :text,    default: ''
  end
end
