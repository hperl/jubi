class ButBoard::PaymentsController < ButBoard::ApplicationController
  load_and_authorize_resource

  # methods: new, create, index
  def new
  end

  def index
  end

  def create
    if @payment.save
      redirect_to but_board_payments_path
    else
      render action: :new
    end
  end

  private
  def filtered_params
    params.require(:payment).permit(:amount, :user_id)
  end

end
