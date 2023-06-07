module ControllerMacros
  def login_user(user)
    user = (user == :user) ? nil : user
    before(:each) do
      @user = create(:user, user)
      sign_in(@user)
    end
  end
end
