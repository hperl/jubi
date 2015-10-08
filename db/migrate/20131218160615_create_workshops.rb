class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string     :title
      t.string     :trainers, default: ''
      t.text       :description
      t.string     :price

      t.text       :location_requirements
      t.text       :timeframe
      t.text       :materials

      t.belongs_to :user
      t.timestamps
    end
  end
end
