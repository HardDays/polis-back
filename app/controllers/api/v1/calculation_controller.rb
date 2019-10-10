module Api
  module V1
    class CalculationController < ApplicationController

      def first_calc
        render json: CalculationHelper.prev_calculate(params) , status: :ok
      end

      def full_calc
        render json: CalculationHelper.full_calculate(params) , status: :ok
      end

      private

      def calc_param
        params.permit(:type, :power, :year, :multidrive, :exactСalculation, :city, :drivers, :usePeriod)
      end

    end
  end
end