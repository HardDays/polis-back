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
         data = CarBrand.left_outer_joins(:car_models).select("CONCAT_WS(' ', car_brands.title,car_models.title) AS full_title, car_brands.title AS brand, car_models.title AS model").where(" upper(CONCAT_WS(' ', car_brands.title,car_models.title)) SIMILAR TO upper('#{cars_params[:title]}%') ").order('car_brands.id').group('car_brands.id','car_models.title', 'car_brands.title').limit(cars_params[:limit]).offset(cars_params[:offset])
        else
          data = CarBrand.left_outer_joins(:car_models).select("CONCAT_WS(' ', car_brands.title,car_models.title) AS full_title, car_brands.title AS brand, car_models.title AS model").order('car_brands.id').group('car_brands.id','car_models.title', 'car_brands.title').limit(cars_params[:limit]).offset(cars_params[:offset])
        end
        render json: data, status: :ok
      end

      def car_search
         # render json:CarType.where(label:params[:car_mark]).take[:id], status: :ok
         render json: CarHelper.find_car_by_numberplate(cars_params), status: :ok
      end

      def check_ticket
          if %w(VIN BodyNumber ChassisNumber LicensePlate).include? cars_params[:ident_type]
            render json: CarHelper.check_ticket(cars_params), status: :ok
          else
            render json: {message:'Не изветный параметр запроса: <ident_type>', description:'Необходим один из ["VIN", "BodyNumber", "ChassisNumber", "LicensePlate"]'}, status: :not_found
          end
      end

    private
      def set_model
        @model = CarModel.find(params[:id])
      end

      def set_brand
        @brand = CarBrand.find(params[:id])
      end

      def cars_params
         params.permit(:title, :limit, :offset, :number_plate, :ident_type, :ident_number)
      end

    end
  end
end

