require 'rails_helper'

RSpec.describe 'Themes', type: :request do
  let!(:theme) { create(:theme) }

  %i[admin moderator].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'create a new Theme' do
        expect{ post themes_path(theme: attributes_for(:theme)), xhr: true}.to change(Theme, :count).by(1)
      end

      it 'returns new' do
        get new_theme_path
        expect(response).to render_template(:new)
      end

      it 'returns edit' do
        get edit_theme_path(theme)
        expect(response).to render_template(:edit)
      end

      it 'updates' do
        put theme_path(theme, theme: { title: 'New title' })
        theme.reload
        expect(response).to redirect_to(themes_url)
      end

      it 'destroys' do
        expect{ delete theme_path(theme) }.to change(Theme, :count).by(-1)
        expect(response).to redirect_to(themes_path)
      end
    end
  end

  %i[admin moderator user].each do |role|
    describe "#{role} should" do
      login_user(role)

      it "renders show" do
        get theme_path(theme)
        expect(response).to be_successful
        expect(response).to render_template(:show)
      end
    end
  end


  describe 'User should not' do
    login_user(:user)

    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'returns new' do
      get new_theme_path
    end

    it 'create a new Theme' do
      expect{ post themes_path(theme: attributes_for(:theme)), xhr: true}.to change(Theme, :count).by(0)
      expect(response).to redirect_to(root_path)
    end

    it 'returns edit' do
      get edit_theme_path(theme)
    end

    it 'updates' do
      put theme_path(theme, theme: { title: 'New title' })
    end

    it 'destroys' do
      expect{ delete theme_path(theme) }.to change(Theme, :count).by(0)
    end
  end

  describe 'unreg user should not' do
    describe 'with html' do
      after(:each) do
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'not returns new' do
        get new_theme_path
      end

      it 'not renders show' do
        get theme_path(theme)
      end

      it 'not returns edit' do
        get edit_theme_path(theme)
      end

      it 'not updates' do
        put theme_path(theme, theme: { title: 'New title' })
      end

      it 'destroys' do
        expect{ delete theme_path(theme) }.to change(Theme, :count).by(0)
      end
    end

    describe 'with remote js' do
      it 'create a new Theme' do
        expect{ post themes_path(theme: attributes_for(:theme)), xhr: true}.to change(Theme, :count).by(0)
      end
    end
  end
end
