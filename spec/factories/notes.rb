FactoryBot.define do
  factory :note do
    messge { "My important note"}
    association :project
    association :user
  end
end
