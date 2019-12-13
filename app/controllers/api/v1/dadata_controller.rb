module Api
  module V1
    class DadataController < ApplicationController

      def kladr
        render json: DadataHelper.kladr(params[:query], params[:count]), status: :ok
      end

      def kladr_city
        render json: DadataHelper.kladr_city(params[:query]), status: :ok
      end

      def addr
        render json: DadataHelper.addr(params[:query], params[:count], params[:kladr_id]), status: :ok
      end

      def ufms
        render json: DadataHelper.ufms(params[:query], params[:count]), status: :ok
      end

      #TODO: запутанно
      # def amo
      #   render json: AmoHelper.test2(params), status: :ok
      # end
    end
  end
end
