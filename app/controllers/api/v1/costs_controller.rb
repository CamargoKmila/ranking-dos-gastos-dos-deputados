module Api
  module V1
    class CostsController < ApplicationController
      def index
        deputy = Deputy.find(params[:deputy_id])
        costs = deputy.costs.page(params[:page]).per(params[:per_page] || 10)

        render json: CostSerializer.new(costs).serializable_hash
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Deputy not found' }, status: :not_found
      end
    end
  end
end
