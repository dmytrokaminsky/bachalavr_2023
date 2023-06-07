require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user) }

  describe 'moderator should' do
    login_user(:admin)

    it 'edit user' do
      get edit_user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'updates user' do
      put user_path(user, user: { role: 'moderator' })
      expect(response).to redirect_to(User)
    end
  end

  %i[admin moderator user].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns index' do
        get users_path
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end

      it 'returns show' do
        get user_path(user)
        expect(response).to be_successful
        expect(response).to render_template(:show)
      end
    end
  end


  describe 'moderator should not' do
    login_user(:moderator)

    it 'edit user' do
      get edit_user_path(user)
      expect(response).to redirect_to(root_url)
    end

    it 'updates user' do
      put user_path(user, user: { role: 'moderator' })
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'unreg user should' do
    it 'returns index' do
      get users_path
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it 'returns show' do
      get user_path(user)
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end

    describe 'not' do
      after(:each) do
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'edit user' do
        get edit_user_path(user)
      end

      it 'updates user' do
        put user_path(user, user: { role: 'moderator' })
      end
    end
  end

end
