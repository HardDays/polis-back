module Api
  module V1
    class CalculationController < ApplicationController
      #TODO: перепилить
      #finished
      def agreement
        aggr = Agreement.find_by(access_id: params[:access_id], access_code: params[:access_code])
        if aggr
          render json: aggr, details: true
        else
          render status: :not_found
        end
      end
      
      def create_agreement
        # calculation = InguruHelper.prev_calculate(params)
        
        # result = {}
        # result[:calculations] = calculation
        # result[:data] = SaverHelper.save_full_agreement(params)
        
        render json: SaverHelper.save_full_agreement(params), status: :ok
      end

      def full_calculate

        get_insurer
        get_owner
        get_car

        if insurers_params && params[:insurerIsOwner] == 0
          @insurer = SaverHelper.save_insurer(insurers_params, @insurer)
        else
          @insurer = SaverHelper.save_insurer(owners_params, @insurer)
        end

        @owner = SaverHelper.save_owner(owners_params, @owner)
        @car = SaverHelper.save_car_from_calculation(params, @car, @insurer, @owner)

        SaverHelper.save_drivers(drivers_params, @car)

        if params[:insurerIsOwner].to_i == 1
          render json: InguruHelper.full_calculate(params) , status: :ok
        else
          render json: InguruHelper.full_calculate_ins(params) , status: :ok
        end

      end

      private

      def calc_param
        params.permit(:type, :power, :year, :multidrive, :exactСalculation, :city, :drivers, :usePeriod)
      end

      def owners_params
        params.require(:owner).permit(:lastname, :firstname, :middlename, :birthdate, :passportSerial, :passportNumber,
                                      :city, :street, :house, :apartment, :fullkladr, :zip)
      end

      def insurers_params
        params.require(:insurer).permit(:lastname, :firstname, :middlename, :birthdate, :passportSerial, :passportNumber,
                                      :city, :street, :house, :apartment, :fullkladr, :zip)
      end

      def drivers_params
        params.require(:drivers)
      end

      def get_car
        @car = Car.where(Car.where(vin:params[:vin].to_s)).take
      end

      def get_owner
        @owner = Owner.where(inn:params[:owner]['inn'].to_s).or(Owner.where(passportSerial:params[:owner]['passportSerial'].to_s, passportNumber:params[:owner]['passportNumber'].to_s)).take
      end

      def get_insurer
        index = 'insurer'
        if params[:insurerIsOwner].to_i == 1
          index = 'owner'
        end
        @insurer = Insurer.where(inn:params[index]['inn'].to_s).or(Insurer.where(passportSerial:params[index]['passportSerial'].to_s, passportNumber:params[index]['passportNumber'].to_s)).take
      end

      
    end
  end
end