require 'rails_helper'

RSpec.describe "questions/show", type: :view do
  before(:each) do
    @question = create(:question)
  end

  let(:user) { create(:user) }

  it "renders attributes in <p>" do
    enable_pundit(view, user)
    render

    expect(rendered).to match(//)
  end
end
