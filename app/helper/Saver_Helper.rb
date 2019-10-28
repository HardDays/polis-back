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

  def self.save_full_calculation_data(params)
    index = 'insurer'
    if params[:insurerIsOwner].to_i == 1
      index = 'owner'
    end

    @owner = Owner.where(inn:params[:owner]['inn'].to_s).or(Owner.where(passport_serial:params[:owner]['passportSerial'].to_s, passport_number:params[:owner]['passportNumber'].to_s)).take
    @insurer = Insurer.where(inn:params[index]['inn'].to_s).or(Insurer.where(passport_serial:params[:owner]['passportSerial'].to_s, passport_number:params[:owner]['passportNumber'].to_s)).take
    @car = Car.where(number_plate:params['licensePlate'].to_s).or(Car.where(vin:params['vehicle']['vin'].to_s)).take

    save_owner(params)
    save_insurer(params)
    save_car_from_calculation(params)
  end

  def self.save_owner(params)
    if params[:owner]
      if @owner
        @owner.update(params[:owner])
      else
        @owner = Owner.new(params[:owner])
      end
      @owner.save
    end
  end

  def self.save_insurer(params)
    index = 'insurer'
    if params[:insurerIsOwner].to_i == 1
      index = 'owner'
    end
    # get_insurer(params[index]['inn'],params[index]['passportSerial'], params[index]['passportNumber'] )
    if params[index]
      if @insurer
        @insurer.update(params[index])
      else
        @insurer = Insurer.new(params[index])
      end
      @insurer.save
    end

  end

  def self.save_car_from_calculation(params)
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
    car_params['owner_id'] = @owner.id
    car_params['insurers_id'] = @insurer.id

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

    if @car
      @car.update(car_params)
    else
      @car = Car.new(car_params)
    end

    @car.save
  end


  def get_car(vin, number)
    @car = Car.where(number_plate:number.to_s).or(Car.where(vin:vin.to_s)).take
  end

  def get_owner(inn, passport_ser, passport_num)
    @owner = Owner.where(inn:inn.to_s).or(Owner.where(passport_serial:passport_ser.to_s).and(Owner.where(passport_number:passport_num.to_s))).take
  end

  def get_insurer(inn, passport_ser, passport_num)
    @insurer = Insurer.where(inn:inn.to_s).or(Insurer.where(passport_serial:passport_ser.to_s).and(Insurer.where(passport_number:passport_num.to_s))).take
  end

end