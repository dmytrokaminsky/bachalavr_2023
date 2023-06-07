require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'stubbed question' do
    let(:question) { build_stubbed(:question) }

    context 'should' do
      it 'have title' do
        question.title = ''
        expect(question.valid?).to be false
        expect(question.errors[:title]).not_to be_empty
      end
    end
  end

  describe 'created question' do
    let(:question) { create(:question) }

    context 'should' do
      it 'have uniq title' do
        new_question = build_stubbed(:question, title: question.title)
        expect(new_question.valid?).to be false
        expect(new_question.errors[:title]).not_to be_empty
      end
    end

    it 'not have 4 answers with no correct' do
      question.answers = build_list(:answer, 4)
      expect(question.valid?).to be false
      expect(question.errors[:correct]).not_to be_empty
    end

    it 'not have no more 1 answer be correct' do
      question.answers = build_list(:answer, 2) + build_list(:answer, 2, correct: true)
      expect(question.valid?).to be false
      expect(question.errors[:correct]).not_to be_empty
    end

  end

  describe 'question' do
    it 'have 4 answers, no less, no more' do
      question = build_stubbed(:question, answers: [])

      expect(question.valid?).to be false
      expect(question.errors[:answers]).not_to be_empty

      [3, 5].each do |int|
        question.answers = build_list(:answer, int)
        expect(question.valid?).to be false
        expect(question.errors[:answers]).not_to be_empty
      end

      question.answers = build_list(:answer, 3) << build(:answer, correct: true)
      expect(question.valid?).to be true
      expect(question.errors[:answers]).to be_empty
    end
  end
end
