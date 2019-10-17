module CarHelper

  def self.update_cars

    token = Helper.getINGURUToken.to_s
    response = RestClient.get Helper.api_url.to_s, {'Authorization':token, 'Content-Type':'application/json', params:{q:'list_brands'}}

    JSON.parse(response.body)['results'].each do |brand|
      @brand_m = CarBrand.new(title: brand.to_s)
      if @brand_m.save
        models = RestClient.get Helper.api_url.to_s, {'Authorization':token, 'Content-Type':'application/json', params:{q:'list_models', brand:brand}}
        JSON.parse(models.body)['results'].each do |model|
          @model_m = CarModel.new(title: model.to_s, car_brand_id:@brand_m.id.to_i)
          @model_m.save
        end
      end
    end

  end

  def self.find_car_by_numberplate(params)
      token = Helper.getWidgetToken
      response = RestClient.post Helper.api_widget_url.to_s+'/insured_objects/cars/by_number_plate', {'number_plate':params['number_plate'].to_s}.to_json, {'Accept':'application/json, text/plain, */*', 'Content-Type':'application/json', 'Authorization':token}
      result = JSON.parse(response.body)
      if result['vin_number']
        resp = RestClient.post Helper.api_widget_url.to_s+'/insured_objects/cars/ticket_check', {'ident_type':'VIN', 'ident_number':result['vin_number'].to_s}.to_json, {'Accept':'application/json, text/plain, */*', 'Content-Type':'application/json', 'Authorization':token}
        result['dc'] = JSON.parse(resp.body)
      end
      return result
  end

  def self.check_ticket(params)
      response = RestClient.post Helper.api_widget_url.to_s+'/insured_objects/cars/ticket_check', {'ident_type':params['ident_type'].to_s, 'ident_number':params['ident_number'].to_s}.to_json, {'Accept':'application/json, text/plain, */*', 'Content-Type':'application/json', 'Authorization':Helper.getWidgetToken}
      return response.body
  end


end
