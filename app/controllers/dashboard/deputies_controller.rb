module Dashboard
  class DeputiesController < ApplicationController
    def index
      if params[:search].present?
        term = "%#{params[:search]}%"
        @deputies = Deputy.includes(:costs).where("txNomeParlamentar ILIKE ? OR party ILIKE ? OR uf ILIKE ?", term, term, term)
      else
        @deputies = Deputy.includes(:costs).all
      end
    end

    def show
      @deputy = Deputy.find(params[:id])
      @total_spending = @deputy.costs.sum(:vlrLiquido)
      @costs = @deputy.costs.order(datEmissao: :desc)
      @biggest_expense = @deputy.costs.order(vlrLiquido: :desc).first
    end
  end
end
