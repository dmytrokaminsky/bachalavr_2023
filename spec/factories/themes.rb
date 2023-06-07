FactoryBot.define do
  factory :theme do
    sequence(:title) { |n| "Theme number #{n}" }

    factory :theme_with_questions do
      transient do
        questions_count { 2 }
      end

      after(:create) do |theme, evaluator|
        create_list(:question, evaluator.questions_count, theme: theme)
      end
    end
  end
end
