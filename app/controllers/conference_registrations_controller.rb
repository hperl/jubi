class ConferenceRegistrationsController < ApplicationController
  layout 'profile'
  before_filter :load_user
  load_and_authorize_resource

  # methods: new, create, edit, update
  def new
  end

  def edit
  end

  def create
    if @conference_registration.save
      redirect_to profile_path
    else
      render action: :new
    end
  end

  def destroy
    @conference_registration.cancel
    redirect_to profile_path
  end

  def update
    if @conference_registration.update_attributes(filtered_params)
      redirect_to profile_path
    else
      render action: :edit
    end
  end

  private

  def filtered_params
    params.require(:conference_registration).permit(
      :person,
      :arrival,
      :departure
    )
  end
end
