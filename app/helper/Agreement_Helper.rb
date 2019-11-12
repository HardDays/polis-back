module AgreementHelper

    def self.save_car(params)
        if params["id"]
            @car = Car.find(params["id"])
            if @car
                @car.update(params)
            else
                @car = Car.new(params)
            end
        else
            @car = Car.find_by vin: params[:vin]
            if @car
                @car.update(params)
            else
                @car = Car.new(params)
            end
        end

        
        @car.save
        return @car.to_json
  
    end

    def self.save_owner(params)
        if params["id"]
            @owner = Owner.find params["id"]

            if @owner
                @owner.update params
            else
                @owner = Owner.new params
            end
        else
            @owner = Owner.new params
        end
        @owner.save
        return @owner.to_json
    end


    def self.save_insurer(params)
        if params["id"]
            @insurer = Insurer.find params["id"]

            if @insurer
                @insurer.update params
            else
                @insurer = Insurer.new params
            end
        else
            @insurer = Insurer.new params
        end
        @insurer.save
        return @insurer.to_json
    end


    def self.save_agreement(params)
        return params
     
    end
end