class CreateInvitations < ActiveRecord::Migration
  def change
    create_table(:invitations, id: false) do |t|
      t.string :id
      t.string :email
      t.integer :group_id

      t.timestamps
    end

    remove_column :groups, :password, :string
  end
end
