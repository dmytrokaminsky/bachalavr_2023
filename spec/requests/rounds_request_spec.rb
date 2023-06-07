 require 'rails_helper'

RSpec.describe 'Rounds', type: :request do
  let!(:round) { create(:round) }

  %i[admin moderator].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns index' do
        get rounds_path
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end

      it 'renders result all users' do
        expect{get result_round_path(round)}
          .to change(Round.where(finished: true), :count).by(1)
        expect(response).to be_successful
        expect(response).to render_template(:result)
      end
    end
  end

  %i[admin moderator user].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'not renders show' do
        get round_path(round)
        expect(response).to redirect_to(root_path)
      end

      it 'return new' do
        expect{ get new_round_url, params: { theme_id: create(:theme_with_questions).id }}
          .to change(Round, :count).by(1)
        expect(response).to redirect_to(round_url(Round.last))
      end

      it 'not return new if theme does not have questions' do
        expect {
          get new_round_url, params: { theme_id: create(:theme).id }
        }.to change(Round, :count).by(0)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'User should' do
    login_user(:user)

    it 'not returns index' do
      get rounds_url
      expect(response).to redirect_to(root_path)
    end

    it 'not renders result if not own round' do
      expect{get result_round_path(round)}
        .to change(Round.where(finished: true), :count).by(0)
      expect(response).to redirect_to(root_path)
    end

    describe 'own round' do
      let!(:own_round) { create(:round, user: @user) }

      it 'get result' do
        expect{get result_round_path(own_round)}
          .to change(Round.where(finished: true), :count).by(1)
        expect(response).to be_successful
        expect(response).to render_template(:result)
      end

      it 'get show' do
        get round_path(own_round)
        expect(response).to be_successful
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'unreg user should not' do
    after(:each) do
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'returns index' do
      get rounds_path
    end

    it 'returns show' do
      get round_path(round)
    end

    it 'renders result' do
      expect{get result_round_path(round)}
        .to change(Round.where(finished: true), :count).by(0)
    end
  end
end
