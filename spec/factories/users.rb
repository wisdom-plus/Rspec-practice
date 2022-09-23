# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:owner] do
    first_name { 'Aaron' }
    last_name { 'Sumner' }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'dottle-nouveau-pavilion-tights-furze' }

    trait :other_user do
      first_name { 'Jane' }
      last_name { 'Tester' }
    end
  end
end
