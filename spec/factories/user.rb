FactoryBot.define do
  factory :user do
    provider { "github" }
    uid { SecureRandom.uuid }
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
  end
end
