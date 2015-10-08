class AddEarlyBirdToButRegistration < ActiveRecord::Migration
  def change
    add_column :but_registrations, :is_early_bird, :boolean, default: false

    ButRegistration.reset_column_information
    ButRegistration.all.each do |reg|
      if reg.payed?
        reg.update_attributes!(is_early_bird: true)
      end
    end
  end
end
