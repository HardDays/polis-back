
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

      def kladr
        response = RestClient.post Helper.dadata_url.to_s,
        {
          :count => params[:count],
          :from_bound => {
            :value => "city"
          },
          :query => params[:query],
          :to_bound => {
            :value => "settlement"
          }
        }.to_json,
        {
            'Authorization':Helper.dadata_token.to_s,
            'Content-Type':'application/json'
        }
        render json: JSON.parse(response.body)["suggestions"], status: :ok
      end

      def addr
        response = RestClient.post Helper.dadata_url.to_s,
        {
          :count => params[:count],
          :query => params[:query],
          :locations => [
            {
              :kladr_id => params[:kladr_id]
            }
          ],
          :restrict_value => true
          
        }.to_json,
        {
            'Authorization':Helper.dadata_token.to_s,
            'Content-Type':'application/json'
        }
        render json: JSON.parse(response.body)["suggestions"], status: :ok
      end

      def ufms
        response = RestClient.post "https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/fms_unit",
        {
          :count => params[:count],
          :query => params[:query],
        }.to_json,
        {
          'Authorization':Helper.dadata_token.to_s,
          'Content-Type':'application/json'
        }
        render json: JSON.parse(response.body)["suggestions"], status: :ok
      end

      def amo
        render json: AmoHelper.test2(params), status: :ok
      end

      private
        def custom_params
          params.permit(:region, :district, :name)
        end

    end
  end
end
