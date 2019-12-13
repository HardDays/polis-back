module Api
  module V1
    class UsetypeController < ApplicationController

      def list
        render json: CarUsetype.all.order('created_at ASC'), status: :ok
      end

      def show
        set_type
        render json: @model, status: :ok
      end

      private
      def set_type
        @model = CarUsetype.find(params[:id])
      end

    end
  end
end
