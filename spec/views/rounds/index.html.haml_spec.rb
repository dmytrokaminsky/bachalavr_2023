require 'rails_helper'

RSpec.describe "rounds/index", type: :view do
  before(:each) do
    @rounds = create_list(:round, 2)
  end

  let(:user) { create(:user, :admin) }

  it "renders a list of rounds" do
    enable_pundit(view, user)

    render

    @rounds.each do |round|
      assert_select "tr>td", text: "#{datetime round.created_at}", count: 2
      assert_select "tr>td", text: round.user.login.to_s, count: 1
      assert_select "tr>td", text: round.theme.title.to_s, count: 1
    end
  end
end
