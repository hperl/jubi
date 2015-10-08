class WorkshopChoicesController < ApplicationController
  def create
    # load models
    registration = current_user.registrations.votable.find(params[:but_registration_id])
    workshop = Workshop.find params[:workshop_id]
    choice_type = params[:choice_type]
    # check if user can edit this but registration
    authorize! :edit, registration
    # construct an array of workshops whose views need updating
    @workshops = [workshop]
    delete_only = registration.workshop_choices.choice.where(workshop: workshop).try(:first).try(:choice_type) == choice_type
    registration.workshop_choices.choice.each do |wc|
      # it makes no sense to choose a workshop multiple times
      if wc.workshop_id == workshop.id
        registration.workshop_choices.delete wc
      end
      # throw out workshops whose timeslots overlap with the chosen workshop
      if wc.choice_type == choice_type and
         wc.workshop.timeslots.any? { |tf| tf.in? workshop.timeslots }
        @workshops << wc.workshop
        registration.workshop_choices.delete wc
      end
    end
    # insert workshop choice
    unless delete_only
      registration.workshop_choices.create!({
        workshop_id: workshop.id,
        choice_type: choice_type
      })
      registration.save!
    end

    respond_to do |format|
      format.js do
        if workshop.timeslots.first.tournament?
          @timeslot = workshop.timeslots.first
          render action: 'tournament', layout: false
        else
          render action: 'create', layout: false
        end
      end
      format.html { redirect_to workshops_path }
    end
  end
end
