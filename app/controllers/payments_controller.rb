class PaymentsController < ApplicationController
  layout 'profile'

  authorize_resource

  def index
    @transactions = current_user.transactions
  end
end
