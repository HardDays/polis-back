require 'securerandom'
module SaverHelper

  def self.save_full_agreement(params)
    if params[:vehicle]
      @vehicle = SaverHelper.save_car params[:vehicle]
    end

    if params[:owner]
      @owner = SaverHelper.save_owner(params[:owner])
    end

    if params[:insurer]
      @insurer = SaverHelper.save_insurer(params[:insurer])
    end

    
    result = SaverHelper.save_agreement(params, {
      :vehicle => @vehicle,
      :owner => @owner,
      :insurer => @insurer
    },params[:drivers])

    return result
  end

  def self.save_car_from_numberplate_find(params)
    car_params = {}
    car_params[:type] = 1
    car_params[:power] = params["engine_power"]
    car_params[:year] = params["manufacturing_year"]
    car_params[:vin] = params["vin_number"]
    
    car_params[:docType] = params["sts"] ? 1 : (params["pts"] ? 0 : 2)

    if car_params[:docType] != 2
      car_params[:docSerial] = params["credential"][0]["series"]
      car_params[:docNumber] = params["credential"][0]["number"]
    end

    car_params[:brand] = params["car_mark"].to_s.upcase
    car_params[:model] = params["car_model"].to_s.upcase


    if params["dc"]
      car_params[:dc] = params["dc"]["number"]
      car_params[:dcDate] = params["dc"]["next_to"]
    end

   @car = Car.find_by vin: car_params[:vin]

    if @car
      @car.update(car_params)
    else
      @car = Car.new(car_params)
    end

    @car.save
    return @car.to_json

  end
  def self.save_owner(params)
    owner = self.get_owner_or_insurer_model params
    if params["id"]
        @owner = Owner.find params["id"]

        if @owner
            @owner.update owner
        else
            @owner = Owner.new owner
        end
    else
        @owner = Owner.new owner
    end
    @owner.save
    return @owner
end


def self.save_insurer(params)
  owner = self.get_owner_or_insurer_model params
    if params["id"]
        @insurer = Insurer.find params["id"]

        if @insurer
            @insurer.update owner
        else
            @insurer = Insurer.new owner
        end
    else
        @insurer = Insurer.new owner
    end
    @insurer.save
    return @insurer
end


def self.save_agreement(aggr, data, drivers)
  agreement = self.get_agreement_model aggr

  if data[:vehicle] && data[:vehicle][:id]
    agreement[:car_id] = data[:vehicle][:id]
  end
  if data[:owner] && data[:owner][:id]
    agreement[:owner_id] = data[:owner][:id]
  end
  if data[:insurer] && data[:insurer][:id]
    agreement[:insurer_id] = data[:insurer][:id]
  end

  agreement[:access_id] = SecureRandom.uuid
  agreement[:access_code] = (0...50).map { ('a'..'z').to_a[rand(26)] }.join

  if agreement[:id]
    @agr = Agreement.find agreement[:id]

    if @agr
      @agr.update agreement
    else
      @agr = Agreement.new agreement
    end
  else
    @agr = Agreement.new agreement
  end

  @agr.save

  agreement[:id] = @agr[:id]
  agreement[:vehicle] = data[:vehicle]
  agreement[:owner] = data[:owner]
  agreement[:insurer] = data[:insurer]
  agreement[:drivers] = self.save_drivers(drivers, agreement)
  return agreement
end

  def self.save_drivers(drivers_list, agreement)
    result = [];
    drivers_list.each do |driver|
      driver_params = {}
      driver_params['lastname'] = driver['lastname']
      driver_params['firstname'] = driver['firstname']
      driver_params['middlename'] = driver['middlename']
      driver_params['birthdate'] = driver['birthdate']
      driver_params['expdate'] = driver['expdate']
      driver_params['licenseSerial'] = driver['licenseSerial']
      driver_params['licenseNumber'] = driver['licenseNumber']
      driver_params['licenseDate'] = driver['licenseDate']
      driver_params['licenseForeign'] = driver['licenseForeign ']
      driver_params['prevLicenseSerial'] = driver['prevLicenseSerial']
      driver_params['prevLicenseNumber'] = driver['prevLicenseNumber']
      driver_params['prevLicenseDate'] = driver['prevLicenseDate']
      driver_params['agreement_id'] = agreement[:id]


      if driver["id"]
        _driver = Driver.find(driver["id"])
      end

      if _driver
        _driver.update(driver_params)
      else
        _driver = Driver.new(driver_params)
      end
      _driver.save
      result.push _driver
    end
    return result
  end

  def self.save_car(params)
    

    car_params = self.get_car_model params

    @car = Car.find_by vin: car_params[:vin]

    if @car
      @car.update(car_params)
    else
      @car = Car.new(car_params)
    end
    @car.save
    return @car
end

def self.get_car_model(params)
  car_params = {}
  car_params[:type] = params["type"]
  car_params[:power] = params["power"]
  car_params[:year] = params["year"]
  car_params[:vin] = params["vin"]
  
  car_params[:docType] = params["docType"]

  car_params[:docSerial] = params["docSerial"]
  car_params[:docNumber] = params["docNumber"]

  car_params[:brand] = params["brand"].to_s.upcase
  car_params[:model] = params["model"].to_s.upcase

  car_params[:dc] = params["dc"]
  car_params[:dcDate] = params["dcDate"]
  return car_params
end

def self.get_owner_or_insurer_model(params)
  result = {}
  result[:lastname] = params["lastname"]
  result[:firstname] = params["firstname"]
  result[:middlename] = params["middlename"]
  result[:birthdate] = params["birthdate"]
  result[:passportSerial] = params["passportSerial"]
  result[:passportNumber] = params["passportNumber"]
  result[:passportDate] = params["passportDate"]
  result[:passportForeign] = params["passportForeign"]
  result[:city] = params["city"]
  result[:street] = params["street"]
  result[:house] = params["house"]
  result[:apartment] = params["apartment"]
  result[:fullkladr] = params["fullkladr"]
  result[:zip] = params["zip"]
  result[:fullAddress] = params["fullAddress"]

  return result
end

def self.get_agreement_model(params)
  result = {}
  result[:id] = params["id"]
  result[:access_id] = params["access_id"]
  result[:access_code] = params["access_code"]
  result[:car_id] = params["car_id"]
  result[:multidrive] = params["multidrive"]
  result[:owner_id] = params["owner_id"]
  result[:insurer_id] = params["insurer_id"]
  result[:licensePlate ] = params["licensePlate"]
  result[:purpose] = params["purpose"]
  result[:registeredAbroad] = params["registeredAbroad"]
  result[:registrationWay] = params["registrationWay"]
  result[:useTrailer] = params["useTrailer"]
  result[:violations] = params["violations"]
  result[:date] = params["date"]
  result[:usePeriod] = params["usePeriod"]
  result[:name] = params["name"]
  result[:phone] = params["phone"]
  result[:email] = params["email"]

  return result
end

def self.get_full_agreement(params)
  result = {};
  aggr = Agreement.where(access_id: params[:access_id], access_code: params[:access_code]).take!

  if aggr
    aggr.attributes.each do |attr_name, attr_value|
      result[attr_name] = attr_value
    end

    if result["car_id"]
      result[:vehicle] = Car.find result["car_id"]
    end

    if result["owner_id"]
      result[:owner] = Owner.find result["owner_id"]
    end

    if result["insurer"]
      result[:insurer] = Insurer.find result["insurer"]
    end

    result[:drivers] = Driver.where(agreement_id: aggr["id"])
  end
  return result
end




end