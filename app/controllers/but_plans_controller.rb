class ButPlansController < ApplicationController
  before_filter :load_user

  def show
  end

  private
  def filtered_params
    params.require(:user)
  end
end
