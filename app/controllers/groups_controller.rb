class GroupsController < ApplicationController
  layout 'profile'
  load_and_authorize_resource

  # methods: new, create, edit, update
  def new
  end

  def edit
  end

  def show
  end

  def create
    if @group.save
      create_invitations @group.email_addresses
      redirect_to profile_path
    else
      render action: :new
    end
  end

  def destroy
    @group.destroy
    redirect_to profile_path
  end

  def leave
    @group.users.delete current_user
    @group.save
    redirect_to profile_path
  end

  private

  def filtered_params
    params.require(:group).permit(:name, :email_addresses)
  end
end
