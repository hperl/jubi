class PagesController < ApplicationController
  include HighVoltage::StaticPage
  layout :layout_for_page

  private
  def layout_for_page
    raise 'boom'
    if params[:id] =~ /^hilfe\//
      'help'
    else
      'application'
    end
  end
end
