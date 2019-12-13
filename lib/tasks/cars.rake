namespace :cars do
    task create: [:environment] do
        
        brands = InguruHelper.brands

        brands.each do |brand_name|
            brand = CarBrand.new(title: brand_name)
            puts 'brand importing: ' + brand_name
            if brand.save
                models = InguruHelper.models(brand_name)
                models.each do |model_name|
                    model = CarModel.new(title: model_name, car_brand_id: brand.id)
                    model.save
                end
            end
        end
    end
end