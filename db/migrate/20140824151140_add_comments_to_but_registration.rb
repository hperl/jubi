class AddCommentsToButRegistration < ActiveRecord::Migration
  def change
    add_column :but_registrations, :comment, :text
  end
end
