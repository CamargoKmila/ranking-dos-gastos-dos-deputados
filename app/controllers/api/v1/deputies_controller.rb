module Api
  module V1
    class DeputiesController < ApplicationController
      def index
        deputies = Deputy.all
        render json: DeputySerializer.new(deputies).serializable_hash
      end

      def total_spending
        deputy = Deputy.find_by(id: params[:id])

        if deputy
          total = deputy.costs.sum(:vlrLiquido)
          render json: { deputy_id: deputy.id, total_spending: total.to_f }
        else
          render json: { error: 'Deputy not found' }, status: :not_found
        end
      end
    end
  end
end
