module Api
  module V1
    class CarsController < ApplicationController

      def index
        if cars_params[:title]
          data = CarBrand.left_outer_joins(:car_models).select("CONCAT_WS(' ', car_brands.title,car_models.title) AS full_title, car_brands.title AS brand, car_models.title AS model").where(" upper(CONCAT_WS(' ', car_brands.title,car_models.title)) LIKE upper('%#{cars_params[:title]}%') ").order('car_brands.id').group('car_brands.id','car_models.title', 'car_brands.title').limit(cars_params[:limit]).offset(cars_params[:offset])
        else
          data = CarBrand.left_outer_joins(:car_models).select("CONCAT_WS(' ', car_brands.title,car_models.title) AS full_title, car_brands.title AS brand, car_models.title AS model").order('car_brands.id').group('car_brands.id','car_models.title', 'car_brands.title').limit(cars_params[:limit]).offset(cars_params[:offset])
        end
        render json: data, status: :ok
      end

      def create
        result = AgentappHelper.find_car(params[:number_plate])

        if result['vin_number']
          car_params = {}
          
          car_params[:type] = 1
          car_params[:power] = result["engine_power"]
          car_params[:year] = result["manufacturing_year"]
          car_params[:vin] = result["vin_number"]
          
          car_params[:docType] = result["sts"] ? 1 : (result["pts"] ? 0 : 2)
      
          if car_params[:docType] != 2
            car_params[:docSerial] = result["credential"][0]["series"]
            car_params[:docNumber] = result["credential"][0]["number"]
          end
      
          car_params[:brand] = result["car_mark"].to_s.upcase
          car_params[:model] = result["car_model"].to_s.upcase
      
          ticket = AgentappHelper.ticket_check(:VIN, result['vin_number'])
          if ticket
            car_params[:dc] = ticket["number"]
            car_params[:dcDate] = ticket["next_to"]
          end
      
          car = Car.find_by(vin: car_params[:vin])
        
          if car
            car.update(car_params)
          else
            car = Car.new(car_params)
            car.save
          end      
          render json: car
        end
      end

      # def ticket_check
      #   if %w(VIN BodyNumber ChassisNumber LicensePlate).include?(cars_params[:ident_type])
      #     render json: AgentappHelper.ticket_check(params[:ident_type], params[:vin_number]), status: :ok
      #   else
      #     render json: {message:'Не изветный параметр запроса: <ident_type>', description:'Необходим один из ["VIN", "BodyNumber", "ChassisNumber", "LicensePlate"]'}, status: :not_found
      #   end
      # end

      private
        def cars_params
          params.permit(:title, :limit, :offset, :number_plate, :ident_type, :ident_number)
        end
    end
  end
end

