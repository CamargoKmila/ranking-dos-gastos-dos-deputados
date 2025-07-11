require 'rails_helper'

RSpec.describe 'Api::V1::Deputies', type: :request do
  describe 'GET /api/v1/deputies' do
    before do
      create_list(:deputy, 7)
    end

    it 'returns the first page with 5 deputies' do
      get '/api/v1/deputies', params: { page: 1, per_page: 5 }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data].size).to eq(5)
      expect(json[:meta][:current_page]).to eq(1)
      expect(json[:meta][:total_pages]).to eq(2)
      expect(json[:meta][:total_count]).to eq(7)
      expect(json[:data].first[:attributes].keys).to include(:txNomeParlamentar, :cpf)
    end

    it 'returns the second page with 2 deputies' do
      get '/api/v1/deputies', params: { page: 2, per_page: 5 }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data].size).to eq(2)
      expect(json[:meta][:current_page]).to eq(2)
      expect(json[:meta][:total_pages]).to eq(2)
      expect(json[:meta][:total_count]).to eq(7)
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

  describe 'GET /api/v1/deputies/:id/biggest_expense' do
    let(:deputy) { create(:deputy) }

    before do
      create(:cost, deputy: deputy, vlrLiquido: 100)
      create(:cost, deputy: deputy, vlrLiquido: 300)
      create(:cost, deputy: deputy, vlrLiquido: 200)
    end

    it 'returns the biggest expense of the deputy' do
      get "/api/v1/deputies/#{deputy.id}/biggest_expense"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.dig('data', 'attributes', 'vlrLiquido').to_f).to eq(300.0)
    end

    it 'returns 404 if deputy not found' do
      get "/api/v1/deputies/999999/biggest_expense"

      expect(response).to have_http_status(:not_found)
      json = JSON.parse(response.body)
      expect(json['error']).to eq('Deputy not found')
    end

    it 'returns 404 if deputy has no expenses' do
      new_deputy = create(:deputy)

      get "/api/v1/deputies/#{new_deputy.id}/biggest_expense"

      expect(response).to have_http_status(:not_found)
      json = JSON.parse(response.body)
      expect(json['error']).to eq('No expenses found for this deputy')
    end
  end
end
