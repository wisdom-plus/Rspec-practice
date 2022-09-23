FactoryBot.define do
  factory :note do
    messge { "My important note"}
    association :project
    user { project.owner }
  end
end
