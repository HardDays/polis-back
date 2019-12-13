module CarHelper

  def self.update_cars

    token = Helper.getINGURUToken.to_s
    response = RestClient.get Helper.api_url.to_s, {'Authorization':token, 'Content-Type':'application/json', params:{q:'list_brands'}}

    JSON.parse(response.body)['results'].each do |brand|
      # if /([a-zA-Z]+[\s\-\_]?[a-zA-Z])+/ === brand || /$ВАЗ|ЗАЗ|ГАЗ^/ === brand
        @brand_m = CarBrand.new(title: brand.to_s)
        if @brand_m.save
          models = RestClient.get Helper.api_url.to_s, {'Authorization':token, 'Content-Type':'application/json', params:{q:'list_models', brand:brand}}
          JSON.parse(models.body)['results'].each do |model|
            @model_m = CarModel.new(title: model.to_s, car_brand_id:@brand_m.id.to_i)
            @model_m.save
          end
        end
      # end
    end

  end

  def self.find_car_by_numberplate(params)
      token = Helper.getWidgetToken
      #token = 'Token afdd5a46a8b02eb8242997711a614dec91ea09af'
      response = RestClient.post Helper.api_widget_url.to_s+'/insured_objects/cars/by_number_plate', {'number_plate':params['number_plate'].to_s}.to_json, {'Accept':'application/json, text/plain, */*', 'Content-Type':'application/json', 'Authorization':token}
      if response.code.to_i != 200 && response.code.to_i != 201
       return response
      end
      #return response.body

      result = JSON.parse(response.body)
      
      # return result
      if result['vin_number']
        resp = RestClient.post Helper.api_widget_url.to_s+'/insured_objects/cars/ticket_check', {'ident_type':'VIN', 'ident_number':result['vin_number'].to_s}.to_json, {'Accept':'application/json, text/plain, */*', 'Content-Type':'application/json', 'Authorization':token}
        if resp.code.to_i == 200
          result['dc'] = JSON.parse(resp.body)
        end
      end
      #return result
      return SaverHelper.save_car_from_numberplate_find(result)
      # end
      # return result
  end

  def self.check_ticket(params)
      response = RestClient.post Helper.api_widget_url.to_s+'/insured_objects/cars/ticket_check', {'ident_type':params['ident_type'].to_s, 'ident_number':params['ident_number'].to_s}.to_json, {'Accept':'application/json, text/plain, */*', 'Content-Type':'application/json', 'Authorization':Helper.getWidgetToken}
      return response.body
  end

end
