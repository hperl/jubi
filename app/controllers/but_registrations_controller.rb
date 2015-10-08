class ButRegistrationsController < ApplicationController
  layout 'profile'
  before_filter :load_user
  load_and_authorize_resource

  # methods: new, create, edit, update
  def new
  end

  def edit
  end

  def create
    if @but_registration.save
      redirect_to profile_path
    else
      render action: :new
    end
  end

  def destroy
    @but_registration.cancel
    redirect_to profile_path
  end

  def update
    if @but_registration.update_attributes(filtered_params)
      redirect_to profile_path
    else
      render action: :edit
    end
  end

  private

  def filtered_params
    params.require(:but_registration).permit(:name,
                                             :nickname,
                                             :email,
                                             :sex,
                                             :age,
                                             :lg,
                                             :address,
                                             :diet,
                                             :diet_other,
                                             :estimated_checkin_day,
                                             :estimated_checkin_time,
                                             :estimated_checkout_day,
                                             :estimated_checkout_time,
                                             :transportation,
                                             :comment,
                                             :accomodation,
                                             :room_mates,
                                             :accomodation_group_id,
                                             :t_shirt_size,
                                             :t_shirt_amount,
                                             :visible,
                                             :wants_to_help_freestyler,
                                             :wants_to_help_checkin,
                                             :wants_to_help_party,
                                             :wants_to_help_kiosk,
                                             :wants_to_help_ersthelfer,
                                             :wants_to_help_grillen,
                                             :wants_to_offer_workshop)
  end
end
