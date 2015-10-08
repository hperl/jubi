class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table(:registrations) do |t|
      t.string     :name,     :null => false, :default => ""
      t.text       :address,  :null => false, :default => ""
      t.string     :nickname

      t.datetime   :estimated_checkin
      t.datetime   :estimated_checkout

      # interests
      t.boolean    :wants_to_offer_workshop, default: false
      t.boolean    :wants_to_help          , default: false

      t.belongs_to :user
      t.timestamps
    end

    remove_column :users, :name,     :string
    remove_column :users, :nickname, :string
    remove_column :users, :address,  :text
  end
end
