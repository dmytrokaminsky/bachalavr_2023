FactoryBot.define do
  factory :result do
    question
    answer
    round
    success { false }
  end
end
