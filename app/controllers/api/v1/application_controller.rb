
module Api
  module V1
    class ApplicationController < ApplicationController
      def auth
        render json: {token: Helper.getINGURUToken.to_s}, status: :ok
      end

      def regions
        response = RestClient.get Helper.api_url.to_s, {'Authorization':Helper.getINGURUToken.to_s, 'Content-Type':'application/json', params:{q:'kladr', region: params[:regId], district: params[:distId]}}
        render json: JSON.parse(response.body)['results'], status: :ok
      end

      def update_cars
        CarHelper.update_cars
         render status: :ok
      end

      def polis_document
        render json: CalculationHelper.polis_doc(params) , status: :ok
      end

      private
        def custom_params
          params.permit(:region, :district, :name)
        end

    end
  end
end
