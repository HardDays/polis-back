module Api
  module V1
    class CalculationController < ApplicationController

      def first_calc
        render json: CalculationHelper.prev_calculate(params) , status: :ok
      end

      def full_calc
        # render json: params[:insurerIsOwner] , status: :ok
        SaverHelper.save_full_calculation_data(params)
        # if params[:insurerIsOwner].to_i == 1
        #   render json: CalculationHelper.full_calculate(params) , status: :ok
        # else
        #   render json: CalculationHelper.full_calculate_vs_ins(params) , status: :ok
        # end

      end

      private

      def calc_param
        params.permit(:type, :power, :year, :multidrive, :exactСalculation, :city, :drivers, :usePeriod)
      end

    end
  end
end