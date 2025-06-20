module Api
  module V1
    class DeputiesController < ApplicationController
      def index
        deputies = Deputy.page(params[:page]).per(params[:per_page] || 10)
        render json: DeputySerializer.new(deputies, meta: pagination_meta(deputies)).serializable_hash
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

      def biggest_expense
        deputy = Deputy.find_by(id: params[:id])

        return render json: { error: 'Deputy not found' }, status: :not_found unless deputy

        biggest_expense = deputy.costs.order(vlrLiquido: :desc).first

        if biggest_expense
          render json: CostSerializer.new(biggest_expense).serializable_hash
        else
          render json: { error: 'No expenses found for this deputy' }, status: :not_found
        end
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
