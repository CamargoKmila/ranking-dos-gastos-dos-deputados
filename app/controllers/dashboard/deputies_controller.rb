module Dashboard
  class DeputiesController < ApplicationController
    def index
      @deputies = Deputy.includes(:costs).all
    end

    def show
      @deputy = Deputy.find(params[:id])
      @total_spending = @deputy.costs.sum(:vlrLiquido)
      @costs = @deputy.costs.order(datEmissao: :desc)
      @biggest_expense = @deputy.costs.order(vlrLiquido: :desc).first
    end
  end
end
