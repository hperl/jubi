class ChangeRegistration < ActiveRecord::Migration
  def change
    remove_column :registrations, :estimated_checkin,  :datetime
    remove_column :registrations, :estimated_checkout, :datetime

    add_column    :registrations, :estimated_checkin_day,   :integer, default: 0
    add_column    :registrations, :estimated_checkin_time,  :integer, default: 9
    add_column    :registrations, :estimated_checkout_day,  :integer, default: 3
    add_column    :registrations, :estimated_checkout_time, :integer, default: 5

    add_column    :registrations, :accomodation,            :integer, default: 0
    add_column    :registrations, :room_mates,              :integer, default: 0
    add_column    :registrations, :accomodation_group_id,   :integer
  end
end
