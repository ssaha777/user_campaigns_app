# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    campaigns_list { [{ campaign_name: 'cam1', campaign_id: 'id1' }] }
  end
end
