module Api
  module V1
    class CostsController < ApplicationController
      def index
        deputy = Deputy.find(params[:deputy_id])
        costs = deputy.costs.includes(:deputy).page(params[:page]).per(params[:per_page] || 10)

        render json: CostSerializer.new(costs, meta: pagination_meta(costs)).serializable_hash
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Deputy not found' }, status: :not_found
      end

      private

      def pagination_meta(scope)
        {
          current_page: scope.current_page,
          total_pages: scope.total_pages,
          total_count: scope.total_count
        }
      end
    end
  end
end
