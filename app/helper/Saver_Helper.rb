module SaverHelper

  def self.save_car_from_numberplate_find(params)
    get_car(params['vin_number'], params['number_plate'])

    car_params = {}
    car_params['power'] = params['engine_power']
    car_params['number_plate'] = params['number_plate'].to_s
    car_params['year'] = params['manufacturing_year'].to_s
    car_params['vin'] = params['vin_number'].to_s

    car_type = CarType.where(label:params['category'].to_s.upcase).take
    if car_type
      car_params['car_type_id'] = car_type[:id].to_i
    end

    car_brand_id = CarBrand.where(title:params['car_mark'].to_s.upcase).take
    if car_brand_id
      car_params['car_brand_id'] = car_brand_id[:id].to_i
    end

    car_model_id = CarModel.where(title:params['car_model'].to_s.upcase).take
    if car_model_id
      car_params['car_model_id'] = car_model_id[:id].to_i
    end

    if params['dc']
      car_params['dc'] = params['dc']['number']
      car_params['dc_date'] = params['dc']['next_to']
    end

    if @car
      @car.update(car_params)
    else
      @car = Car.new(car_params)
    end

    @car.save

  end

  # def self.save_full_calculation_data(params)
  #   index = 'insurer'
  #   if params[:insurerIsOwner].to_i == 1
  #     index = 'owner'
  #   end
  #
  #   @owner = Owner.where(inn:params[:owner]['inn'].to_s).or(Owner.where(passportSerial:params[:owner]['passportSerial'].to_s, passportNumber:params[:owner]['passportNumber'].to_s)).take
  #   @insurer = Insurer.where(inn:params[index]['inn'].to_s).or(Insurer.where(passportSerial:params[index]['passportSerial'].to_s, passportNumber:params[index]['passportNumber'].to_s)).take
  #   @car = Car.where(number_plate:params['licensePlate'].to_s).or(Car.where(vin:params['vehicle']['vin'].to_s)).take
  #
  #   save_owner(params)
  #   save_insurer(params)
  #   save_car_from_calculation(params)
  # end

  def self.save_owner(params, owner)
    if params
      if owner
        owner.update(params)
      else
        owner = Owner.new(params)
      end
      owner.save
      return owner
    end
  end

  def self.save_insurer(params, insurer)

    # get_insurer(params[index]['inn'],params[index]['passportSerial'], params[index]['passportNumber'] )
    if params
      if insurer
        insurer.update(params)
      else
        insurer = Insurer.new(params)
      end
      insurer.save
      return insurer
    end

  end

  def self.save_car_from_calculation(params, car, insurer, owner)
    # get_car( params['vehicle']['vin'], params['licensePlate'])

    car_params = {}
    car_params['power'] = params['vehicle']['power']
    car_params['number_plate'] = params['licensePlate'].to_s
    car_params['year'] = params['vehicle']['year'].to_s
    car_params['vin'] =  params['vehicle']['vin'].to_s
    car_params['document_type'] = params['vehicle']['docType'].to_i
    car_params['document_serial'] = params['vehicle']['docSerial'].to_s
    car_params['document_number'] = params['vehicle']['docNumber'].to_s
    car_params['dc'] = params['vehicle']['dc'].to_s
    car_params['dc_date'] = params['vehicle']['dcDate'].to_s
    car_params['dc_issue_date'] = params['vehicle']['dcIssueDate'].to_s
    car_params['document_date'] = params['vehicle']['docDate'].to_s
    car_params['use_trailer'] = params['useTrailer'].to_i
    car_params['registered_abroad'] = params['registeredAbroad'].to_i
    car_params['registration_way'] = params['registrationWay'].to_i
    car_params['owner_id'] = owner.id
    car_params['insurers_id'] = insurer.id

    car_brand_id = CarBrand.where(title:params['vehicle']['brand'].to_s.upcase).take
    if car_brand_id
      car_params['car_brand_id'] = car_brand_id[:id].to_i
    end

    car_model_id = CarModel.where(title:params['vehicle']['model'].to_s.upcase).take
    if car_model_id
      car_params['car_model_id'] = car_model_id[:id].to_i
    end

    if params['dc']
      car_params['dc'] = params['dc']['number']
      car_params['dc_date'] = params['dc']['next_to']
    end

    if car
      car.update(car_params)
    else
      car = Car.new(car_params)
    end

    car.save
    return  car
  end

  def self.save_drivers(drivers_list, car)
    drivers_list.each do |driver|
      driver_params = {}
      driver_params['car_id'] = car[:id]
      driver_params['lastname'] = driver['lastname']
      driver_params['firstname'] = driver['firstname']
      driver_params['middlename'] = driver['middlename']
      driver_params['birthdate'] = driver['birthdate']
      driver_params['expdate'] = driver['expdate']
      driver_params['licenseSerial'] = driver['licenseSerial']
      driver_params['licenseNumber'] = driver['licenseNumber']
      driver_params['licenseDate'] = driver['licenseDate']


      _driver = Driver.where(licenseSerial:driver['licenseSerial'].to_s,
                             licenseNumber:driver['licenseNumber'].to_s,
                             car_id:car[:id]).take

      if _driver
        _driver.update(driver_params)
      else
        _driver = Driver.new(driver_params)
      end
      _driver.save
    end
  end

end