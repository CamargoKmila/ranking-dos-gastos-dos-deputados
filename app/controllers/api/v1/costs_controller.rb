module Api
  module V1
    class CostsController < ApplicationController
      def index
        deputy = Deputy.find(params[:deputy_id])
        costs = deputy.costs.page(params[:page]).per(params[:per_page] || 10)

        render json: {
          data: CostSerializer.new(costs).serializable_hash[:data],
          meta: {
            current_page: costs.current_page,
            total_pages: costs.total_pages,
            total_count: costs.total_count
          }
        }
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Deputy not found' }, status: :not_found
      end
    end
  end
end
