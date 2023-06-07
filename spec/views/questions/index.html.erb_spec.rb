require 'rails_helper'

RSpec.describe "questions/index", type: :view do
  before(:each) do
    @questions = create_list(:question, 2)

    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true)

    @pagy, @questions = pagy(@questions)
  end

  let(:user) { create(:user) }

  it "renders a list of questions" do
    enable_pundit(view, user)

    render

  end
end
