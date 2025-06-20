require 'rails_helper'

RSpec.describe 'Api::V1::Deputies', type: :request do
  describe 'GET /api/v1/deputies' do
    before do
      create_list(:deputy, 3)
    end

    it 'returns all deputies' do
      get '/api/v1/deputies'

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      
      expect(json['data'].size).to eq(3)
      first_deputy = json['data'].first
      expect(first_deputy.keys).to include('id', 'type', 'attributes')
      expect(first_deputy['attributes'].keys).to include('txNomeParlamentar', 'ideCadastro')
    end
  end

  describe 'GET /api/v1/deputies/:id/total_spending' do
    let(:deputy) { create(:deputy) }

    before do
      create(:cost, vlrLiquido: 100, deputy: deputy)
      create(:cost, vlrLiquido: 200, deputy: deputy)
    end

    it 'returns total spending for the deputy' do
      get "/api/v1/deputies/#{deputy.id}/total_spending"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['deputy_id']).to eq(deputy.id)
      expect(json['total_spending']).to eq(300.0)
    end

    it 'returns 404 if deputy does not exist' do
      get "/api/v1/deputies/999999/total_spending"

      expect(response).to have_http_status(:not_found)
      json = JSON.parse(response.body)
      expect(json['error']).to eq('Deputy not found')
    end
  end
end
