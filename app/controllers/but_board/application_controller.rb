class ButBoard::ApplicationController < ApplicationController
  layout 'but_board'

  before_filter do
    authorize! :manage, :but_board
  end
end
