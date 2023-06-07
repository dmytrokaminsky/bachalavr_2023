require 'rails_helper'

RSpec.describe Theme, type: :model do
  describe 'stubbed theme' do
    let(:theme) { build_stubbed(:theme) }

    context 'should' do
      it 'have title' do
        theme.title = ''
        expect(theme.valid?).to be false
        expect(theme.errors[:title]).not_to be_empty
      end
    end
  end

  describe 'created theme' do
    let(:theme) { create(:theme) }

    context 'should' do
      it 'have uniq title' do
        new_theme = build_stubbed(:theme, title: theme.title)
        expect(new_theme.valid?).to be false
        expect(new_theme.errors[:title]).not_to be_empty
      end
    end
  end
end
