class InvitationsController < ApplicationController
  before_filter :load_and_authorize_group, except: %w(show)
  before_filter :authenticate_user!,       only:   %w(show)

  # user accepts an invitation
  def show
    begin
      invitation = Invitation.find(params[:id])
      group = invitation.group
      if group.members.include?(current_user)
        flash[:notice] = "Du bist schon in der Gruppe #{group.name}."
      else
        group.users << current_user
        flash[:notice] = "Du bist der Gruppe #{group.name} beigetreten."
      end
      invitation.destroy
      redirect_to group_path(group)
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Die Einladung war ungültig."
      redirect_to profile_path
    end
  end

  def create
    create_invitations params[:invitation][:email_addresses]
    redirect_to group_path(@group)
  end

  def destroy
    Invitation.find(params[:id]).destroy
  end

  private
  def load_and_authorize_group
    @group = Group.find(params[:group_id])
    authorize! :manage, @group
  end

end
