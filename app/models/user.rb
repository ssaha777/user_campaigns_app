class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  scope :by_campaign_names, lambda { |campaign_names|
    where("exists (select from jsonb_array_elements(campaigns_list) as campaign where campaign->>'campaign_name' IN (?) )", campaign_names)
  }
end
