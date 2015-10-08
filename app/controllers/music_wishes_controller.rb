class MusicWishesController < ApplicationController
  layout 'profile'

  before_filter :load_user

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(filtered_params)
      redirect_to music_wishes_path
    else
      render action: :edit
    end
  end

  private
  def filtered_params
    params.require(:user).permit(:music_wishes)
  end
end
