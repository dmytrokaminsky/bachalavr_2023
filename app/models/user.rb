class User < ApplicationRecord
  audited

  has_many :rounds

  enum role: %i[user moderator admin]

  after_initialize :set_default_role, :if => :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  validates :email,
            :login, uniqueness: true
  validates :login, presence:   true,
                    uniqueness: true,
                    exclusion:  { in: LOGIN_BLACKLIST },
                    length:     { in: 3..12 },
                    format:     { with: /\A[A-Za-z0-9_]+\z/ }

  def to_param
    "#{id}-#{login.parameterize}"
  end

  def set_default_role
    self.role ||= :user
  end

  def answers_stat
    correct = self.rounds.sum(:current_answers)
    wrong   = self.rounds.sum(:wrong_answers)
    total   = correct/wrong.to_f * 100
    {correct: correct, wrong: wrong, total: total.round(2)}
  end

  def favorite_theme
    # get count of themes ids
    themes_ids = self.rounds.pluck(:theme_id).each_with_object(Hash.new(0)){|string, hash| hash[string] += 1}
    Theme.find(themes_ids.first[0]) if themes_ids.any?
  end
end
