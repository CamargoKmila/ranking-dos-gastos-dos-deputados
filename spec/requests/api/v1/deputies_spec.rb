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
end
