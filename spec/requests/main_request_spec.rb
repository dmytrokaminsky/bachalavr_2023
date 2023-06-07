require 'rails_helper'

RSpec.describe 'Main', type: :request do

  %i[admin].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns audit' do
        get audit_path
        expect(response).to render_template(:audit)
      end
    end
  end

  %i[user moderator].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'not returns audit' do
        get audit_path
        expect(response).to redirect_to(root_path)
      end
    end
  end



  describe 'unreg user should' do
    it "returns main index" do
      get "/"
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'not returns audit' do
      get audit_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
