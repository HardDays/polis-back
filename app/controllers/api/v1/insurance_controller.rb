module Api
  module V1
    class InsuranceController < ApplicationController

      def list
        render json: InsuranceCompany.all.order('created_at ASC'), status: :ok
        end

      def show
        set_insurance
        render json: @model, status: :ok
      end

      private
      def set_insurance
        @model = InsuranceCompany.find(params[:id])
      end

    end
  end
end

