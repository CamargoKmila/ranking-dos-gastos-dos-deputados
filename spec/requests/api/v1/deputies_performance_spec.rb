require 'rails_helper'
require 'benchmark'

RSpec.describe 'Api::V1::Deputies performance', type: :request do
  before do
    create_list(:deputy, 50)
  end

  it 'responds within 200ms for a single request' do
    time = Benchmark.realtime do
      get '/api/v1/deputies', params: { page: 1, per_page: 20 }
      expect(response).to have_http_status(:ok)
    end

    expect(time).to be < 0.2
  end

  it 'maintains performance across multiple sequential requests' do
    times = []

    5.times do
      time = Benchmark.realtime do
        get '/api/v1/deputies', params: { page: 1, per_page: 20 }
        expect(response).to have_http_status(:ok)
      end
      times << time
    end

    average_time = times.sum / times.size

    expect(average_time).to be < 0.3
  end
end
