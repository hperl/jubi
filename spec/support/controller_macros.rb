module ControllerMacros
  def login_user
    before do
      user = stub_model(User)
      allow(controller).to receive(:authenticate_user!)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end
end
