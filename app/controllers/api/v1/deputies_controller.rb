module Api
  module V1
    class DeputiesController < ApplicationController
      def index
        deputies = Deputy.all
        render json: DeputySerializer.new(deputies).serializable_hash
      end
    end
  end
end