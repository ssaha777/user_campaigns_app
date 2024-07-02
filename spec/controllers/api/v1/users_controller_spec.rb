# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'returns all users as JSON' do
      user = create(:user)
      get :index

      parsed_response = response.parsed_body
      expect(parsed_response).to include(JSON.parse(user.to_json))
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) { { user: attributes_for(:user) } }

      it 'creates a new user' do
        expect do
          post :create, params: valid_params
        end.to change(User, :count).by(1)
      end

      it 'renders a JSON response with the new user' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        parsed_response = response.parsed_body
        expect(parsed_response).to include('id', 'name', 'email', 'campaigns_list', 'created_at', 'updated_at')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { user: { name: nil, email: nil } } }

      it 'renders a JSON response with errors for the new user' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        parsed_response = response.parsed_body
        expect(parsed_response['name']).to include("can't be blank")
        expect(parsed_response['email']).to include("can't be blank")
      end
    end
  end

  describe 'GET #filter' do
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
      get :filter, params: { campaign_names: 'cam3,cam4' }
      parsed_response = response.parsed_body
      expect(parsed_response).to include(JSON.parse(user2.to_json))
      expect(parsed_response).to include(JSON.parse(user3.to_json))
      expect(parsed_response).not_to include(JSON.parse(user1.to_json))
    end

    it 'returns all users if no campaign names are provided' do
      get :filter
      parsed_response = response.parsed_body
      expect(parsed_response).to include(JSON.parse(user1.to_json))
      expect(parsed_response).to include(JSON.parse(user2.to_json))
    end
  end
end
