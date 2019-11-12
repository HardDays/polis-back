module Api
  module V1
    class CalculationController < ApplicationController
      def get_saved_agreement
        params.require(:access_code)
        params.require(:access_id)
        render json: SaverHelper.get_full_agreement(params) , status: :ok
      end
      def save_agr
        render json: SaverHelper.save_full_agreement(params), status: :ok
      end

      def first_calc
        render json: CalculationHelper.prev_calculate(params) , status: :ok
      end

      def get_offer
        params.require(:sk)

        sk = params[:sk]
        aggr = params["agreement"]
        # render json: aggr["vehicle"] , status: :ok
        body = {};
        body[:sk] = [sk.to_i]
        aggr.each do |attr_name, attr_value|
          body[attr_name] = attr_value
        end
        # render json: body , status: :ok
        response = RestClient::Request.execute(method: :post,
          url:  Helper.api_url.to_s,
          payload: body.to_json,
          headers: {
              'Authorization': Helper.getINGURUToken.to_s,
              'Content-Type':'application/json'
                 },
          timeout: 120)
        render json: response.body , status: :ok

      end

      def full_calc

        get_insurer
        get_owner
        get_car

        if insurers_params && params[:insurerIsOwner]==0
          @insurer = SaverHelper.save_insurer(insurers_params, @insurer)
        else
          @insurer = SaverHelper.save_insurer(owners_params, @insurer)
        end

        @owner = SaverHelper.save_owner(owners_params, @owner)
        @car = SaverHelper.save_car_from_calculation(params, @car, @insurer, @owner)

        SaverHelper.save_drivers(drivers_params, @car)

        if params[:insurerIsOwner].to_i == 1
          render json: CalculationHelper.full_calculate(params) , status: :ok
        else
          render json: CalculationHelper.full_calculate_vs_ins(params) , status: :ok
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