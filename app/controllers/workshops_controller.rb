class WorkshopsController < ApplicationController
  layout 'profile', except: :index
  load_and_authorize_resource

  def index
    @workshops = Workshop.regular.visible.order(:title)
  end

  def new
    @workshop = Workshop.new(owner: current_user)
  end

  def edit
  end

  def create
    @workshop = Workshop.new(filtered_params)
    @workshop.owner = current_user
    if @workshop.save
      redirect_to profile_path
    else
      render action: :new
    end
  end

  def update
    if @workshop.update_attributes(filtered_params)
      redirect_to profile_path
    else
      render action: :edit
    end
  end

  def remember
    workshop_ids = current_user.remembered_workshop_ids
    unless workshop_ids.delete(@workshop.id)
      workshop_ids << @workshop.id
    end
    current_user.save!

    respond_to do |format|
      format.js   { render action: 'workshop', layout: false }
      format.html { redirect_to workshops_path }
    end
  end

  def toggle_visibility
    @workshop.update_attribute(:visible, !@workshop.visible?)

    respond_to do |format|
      format.js   { render action: 'workshop', layout: false }
      format.html { redirect_to workshops_path }
    end
  end

  private
  def filtered_params
    params.require(:workshop).permit(:title,
                                     :description,
                                     :timeframe,
                                     :max_tn,
                                     :trainers,
                                     :special_requirements,
                                     :materials,
                                     :price
                                    )
  end

end
