module Api
  module V1
    class  PayController < ApplicationController

      def pay_link
         render json: CalculationHelper.pay_link(params) , status: :ok
      end

      def pay_status
         render json: CalculationHelper.pay_status(params) , status: :ok
      end

    end
  end
end