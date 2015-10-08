class ButBoard::AlgorithmsController < ButBoard::ApplicationController
  def show
  end

  def rerun
    Algorithm.new.run
    redirect_to action: :show
  end
end
