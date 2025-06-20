require 'rails_helper'

RSpec.describe 'Api::V1::Costs', type: :request do
  let(:deputy) { create(:deputy) }
  let!(:costs) { create_list(:cost, 3, deputy: deputy) }

  describe 'GET /api/v1/deputies/:deputy_id/costs' do
    it 'returns all costs of the deputy' do
      get "/api/v1/deputies/#{deputy.id}/costs"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data].length).to eq(3)
      expect(json[:data].first[:attributes].keys).to include(:txtDescricao, :vlrLiquido)
    end

    it 'returns 404 if deputy not found' do
      get "/api/v1/deputies/999999/costs"
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Deputy not found')
    end
  end
end
