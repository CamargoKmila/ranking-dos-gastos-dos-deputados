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
    end
  end
end
