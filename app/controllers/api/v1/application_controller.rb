
module Api
  module V1
    class ApplicationController < ApplicationController
      def auth
        render json: {token: Helper.getINGURUToken.to_s}, status: :ok
      end

      def regions
        response = RestClient.get Helper.api_url.to_s, {'Authorization':Helper.getINGURUToken.to_s, 'Content-Type':'application/json', params:{q:'list_brands'}}
        render json: JSON.parse(response.body)['results'], status: :ok
      end

      def update_cars
        CarHelper.update_cars
        #  render json: RestClient.get Helper.api_url.to_s, {'Authorization':Helper.getINGURUToken.to_s, 'Content-Type':'application/json', params:{q:'list_brands'}}, status: :ok
         render status: :ok
      end

      private
        def custom_params
          params.permit(:region, :district, :name)
        end


    end
  end
end
