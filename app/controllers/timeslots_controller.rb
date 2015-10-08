class TimeslotsController < ApplicationController

  def help
    timeslot = Timeslot.helper_shift.find(params[:timeslot_id])
    but_registration = current_user.registrations.payed.find(params[:but_registration_id])
    user_helper_shifts = but_registration.helper_shift_timeslots
    # construct array of timeslots to be updated
    @timeslots = [timeslot]
    if user_helper_shifts.include? timeslot
      user_helper_shifts.delete timeslot
    else
      # user wants to help.
      # 1) Add helper_shift to user
      if !timeslot.max_tn || timeslot.missing_tn > 0
        # 2) We may have a time conflict here, so delete all timeslots that overlap
        user_helper_shifts.each do |hs|
          if hs.overlaps? timeslot
            @timeslots << hs
            user_helper_shifts.delete hs
          end
        end
        # 3) Lastly, add the selected timeslot
        user_helper_shifts << timeslot
      end
    end
    but_registration.helper_shift_timeslots = user_helper_shifts
    but_registration.save!

    respond_to do |format|
      format.js   { render action: 'timeslot', layout: false }
      format.html { redirect_to but_plan_path }
    end
  end

end
