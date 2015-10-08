class ButBoard::SudoController < ButBoard::ApplicationController

  def show
  end

  def switch
    user = User.where(filtered_params).first
    if user
      flash[:notice] = "Du bist jetzt als #{user.email} angemeldet"
      sign_in(:user, user, {bypass: true})
      redirect_to root_url
    else
      flash[:warning] = "#{filtered_params[:email]} gibt es nicht."
      redirect_to but_board_sudo_path
    end
  end

  private
  def filtered_params
    params.require(:user).permit(:email)
  end
end

