class Result < ApplicationRecord
  audited
  belongs_to :question
  belongs_to :answer, optional: true
  belongs_to :round
end
