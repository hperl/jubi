class ButBoard::WorkshopsController < ButBoard::ApplicationController
  load_and_authorize_resource

  def index
    @workshop_timeslots = Timeslot.workshop
  end

  def create
    @timeslot = Timeslot.find params[:id]
    @workshop = Workshop.find params[:added_workshop]
    @timeslot.workshops << @workshop unless @workshop.in? @timeslot.workshops
    @timeslot.save
    @timeslots = @workshop.timeslots

    respond_to do |format|
      format.html { redirect_to but_board_workshops_path }
      format.js   { render action: 'create', layout: false }
    end
  end

  def destroy
    @workshop = Workshop.find params[:id]
    @timeslot = Timeslot.find params[:timeslot]
    @timeslot.workshops.delete(@workshop)
    @timeslot.save
    @timeslots = @workshop.timeslots + [@timeslot]

    respond_to do |format|
      format.html { redirect_to but_board_workshops_path }
      format.js   { render action: 'create', layout: false }
    end
  end

end
