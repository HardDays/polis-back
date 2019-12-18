module Api
  module V1
    class CarModelsController < ApplicationController

      def index
        render json: CarModel.all.order('created_at ASC')
      end

      def show
        render json: CarModel.find(params[:id])
      end
        
    end
  end
end

