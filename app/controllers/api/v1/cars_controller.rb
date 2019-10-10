module Api
  module V1
    class CarsController < ApplicationController

      def models
        render json: CarModel.all.order('created_at ASC'), status: :ok
        end

      def model
        set_model
        render json: @model, status: :ok
      end

      def brands
        render json: CarBrand.all.order('created_at ASC'), status: :ok
      end

      def brand
        set_brand
        render json: @brand, status: :ok
      end

      def list
        if  cars_params[:title]
         data = CarBrand.left_outer_joins(:car_models).select("CONCAT_WS(' ', car_brands.title,car_models.title) AS full_title").where(" upper(CONCAT_WS(' ', car_brands.title,car_models.title)) LIKE upper('%#{cars_params[:title]}%') ").order('car_brands.id').group('car_brands.id','car_models.title', 'car_brands.title').limit(cars_params[:limit]).offset(cars_params[:offset])
        else
          data = CarBrand.left_outer_joins(:car_models).select("CONCAT_WS(' ', car_brands.title,car_models.title) AS full_title").order('car_brands.id').group('car_brands.id','car_models.title', 'car_brands.title').limit(cars_params[:limit]).offset(cars_params[:offset])
        end
        render json: data, status: :ok
      end

      private
      def set_model
        @model = CarModel.find(params[:id])
      end

      def set_brand
        @brand = CarBrand.find(params[:id])
      end

      def cars_params
         params.permit(:title, :limit, :offset)
      end

    end
  end
end

