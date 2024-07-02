# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = build(:user, name: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid without an email' do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid with a duplicate email' do
    create(:user, email: 'john@example.com')
    user = build(:user, email: 'john@example.com')
    expect(user).to_not be_valid
  end

  describe '.by_campaign_names' do
    let!(:user1) do
      create(:user,
             campaigns_list: [{ campaign_name: 'cam1', campaign_id: 'id1' },
                              { campaign_name: 'cam2', campaign_id: 'id2' }])
    end
    let!(:user2) do
      create(:user,
             campaigns_list: [{ campaign_name: 'cam1', campaign_id: 'id1' },
                              { campaign_name: 'cam3', campaign_id: 'id3' }])
    end
    let!(:user3) { create(:user, campaigns_list: [{ campaign_name: 'cam4', campaign_id: 'id4' }]) }

    it 'returns users filtered by campaign names' do
      result = User.by_campaign_names(%w[cam1 cam2])
      expect(result).to include(user1, user2)
      expect(result).to_not include(user3)
    end

    it 'returns an empty array if no users match the campaign names' do
      result = User.by_campaign_names(['cam5'])
      expect(result).to be_empty
    end
  end
end
