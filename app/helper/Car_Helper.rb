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


end
