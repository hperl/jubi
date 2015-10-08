class PhotosController < ApplicationController
  layout 'profile'

  before_filter :load_user

  def index
  end

  def download
    send_file Rails.root.join('private/fotos/fotos.zip'), disposition: 'attachment', type: 'application/zip'
  end
end
