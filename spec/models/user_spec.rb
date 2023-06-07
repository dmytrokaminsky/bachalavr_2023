require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'simple user' do
    let(:user) { create(:user) }

    context 'should' do
      it 'have user role by default after create' do
        expect(user.user?).to be true
      end

      it 'have user role from list' do
        expect { user.role= 'Superuser' }.to raise_error(ArgumentError)
      end

      it 'have uniq email' do
        new_user = build_stubbed(:user, email: user.email)
        expect(new_user.valid?).to be false
        expect(new_user.errors[:email]).not_to be_empty
      end

      it 'have not login less 3' do
        user.login = 'ma'
        expect(user.valid?).to be false
        expect(user.errors[:login]).not_to be_empty
      end

      it 'have not login more 12' do
        user.login = 'm' * 13
        expect(user.valid?).to be false
        expect(user.errors[:login]).not_to be_empty
      end

      it 'have login' do
        user.login = nil
        expect(user.valid?).to be false
        expect(user.errors[:login]).not_to be_empty
      end

      it 'have not unique login' do
        user.save!
        new_user = build(:user)
        new_user.login = user.login
        expect(new_user.valid?).to be false
        expect(new_user.errors[:login]).not_to be_empty
      end

      it 'have not login with specific symbols' do
        ['log,in', 'my login', 'very-big', '<hello>'].each do |login|
          user.login = login
          expect(user.valid?).to be false
          expect(user.errors[:login]).not_to be_empty
        end
      end

      it 'have not login from blacklist' do
        LOGIN_BLACKLIST.each do |login|
          user.login = login
          expect(user.valid?).to be false
          expect(user.errors[:login]).not_to be_empty
        end
      end

    end
  end
end
