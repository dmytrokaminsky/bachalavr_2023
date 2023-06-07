class Question < ApplicationRecord
  audited

  belongs_to :author, class_name:    'User',
                      foreign_key:   'author_id'
  belongs_to :theme,  counter_cache: true

  has_many :answers, inverse_of: :question, dependent: :destroy
  has_many :results
  has_many :rounds, through: :results

  validates :title, uniqueness: true,
                    presence:   true

  validates :answers, length: { is: 4, message: 'must be four' }

  validate :check_correct_flag

  accepts_nested_attributes_for :answers, reject_if: :all_blank

  def current_answer_id
    answers.where(correct: true).first.id
  end

  private

    # check if correct flag not choose
    #
    def check_correct_flag
      errors.add(:correct, I18n.t('questions.flag_must_exist')) unless self.answers.map(&:correct).count(true) == 1
    end

end
