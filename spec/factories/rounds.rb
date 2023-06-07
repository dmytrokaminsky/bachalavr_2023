FactoryBot.define do
  factory :round do
    current_answers { 1 }
    wrong_answers { 1 }
    finished { false }
    association :theme, factory: [:theme_with_questions]
    user
  end
end
