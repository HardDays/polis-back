module Api
  module V1
    class CartypeController < ApplicationController

      def list
        render json: CarType.all.order('created_at ASC'), status: :ok
      end

      def show
        set_type
        render json: @model, status: :ok
      end

      private
      def set_type
        @model = CarType.find(params[:id])
      end

    end
  end
end

