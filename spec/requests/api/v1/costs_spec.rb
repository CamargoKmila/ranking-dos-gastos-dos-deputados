require 'rails_helper'

RSpec.describe 'Api::V1::Costs', type: :request do
  let(:deputy) { create(:deputy) }

  describe 'GET /api/v1/deputies/:deputy_id/costs' do
    context 'when there are multiple costs' do
      before do
        create_list(:cost, 7, deputy: deputy)
      end

      it 'returns the first page with 5 items' do
        get "/api/v1/deputies/#{deputy.id}/costs", params: { page: 1, per_page: 5 }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data].size).to eq(5)
        expect(json[:meta][:current_page]).to eq(1)
        expect(json[:meta][:total_pages]).to eq(2)
        expect(json[:meta][:total_count]).to eq(7)
        expect(json[:data].first[:attributes].keys).to include(:txtDescricao, :vlrLiquido)
      end

      it 'returns the second page with 2 items' do
        get "/api/v1/deputies/#{deputy.id}/costs", params: { page: 2, per_page: 5 }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data].size).to eq(2)
        expect(json[:meta][:current_page]).to eq(2)
        expect(json[:meta][:total_pages]).to eq(2)
        expect(json[:meta][:total_count]).to eq(7)
      end
    end

    context 'when deputy does not exist' do
      it 'returns 404' do
        get "/api/v1/deputies/999999/costs"

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Deputy not found')
      end
    end
  end
end
