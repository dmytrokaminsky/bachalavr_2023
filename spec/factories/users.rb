FactoryBot.define do
  factory :user do
    login                 { Faker::Lorem.unique.characters(number: 5..9) }
    email                 { Faker::Internet.unique.email }
    password              { 'password' }
    password_confirmation { 'password' }

    trait(:admin) do
      role { 'admin' }
    end

    trait(:moderator) do
      role { 'moderator' }
    end
  end
end
