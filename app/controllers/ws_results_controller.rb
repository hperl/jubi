class WsResultsController < ApplicationController
  layout 'profile'
  before_filter :load_user

  #authorize_resource

  def show
  end
end
