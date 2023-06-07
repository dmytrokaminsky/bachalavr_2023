require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = create(:user)
  end

  it "renders the edit position form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do
      assert_select "select[name=?]", "user[role]"
    end
  end

end
