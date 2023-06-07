FactoryBot.define do
  factory :answer do
    sequence(:title) { |n| "Answer number #{n}" }

    correct { false }
  end
end
