class Theme < ApplicationRecord
  audited

  validates  :title, uniqueness: true,
                     presence:   true

  has_many :questions, dependent: :destroy

  def to_param
    "#{id}-#{title.parameterize}"
  end

end
