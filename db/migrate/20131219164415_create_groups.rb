class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :password
      t.belongs_to :owner
    end

    create_table :groups_users do |t|
      t.belongs_to :group
      t.belongs_to :user
    end
  end
end
