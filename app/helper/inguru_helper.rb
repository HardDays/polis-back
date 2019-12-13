module InguruHelper

    URL = 'https://api.inguru.ru/eosago/4.0'
    FIND_PATH = '/insured_objects/cars/by_number_plate'


    def self.token
        login = 'test@inguru.ru'
        password = '123'
        age = 60*60*24
        time = Time.now.to_i
        hash =  Digest::MD5.hexdigest(login+':'+time.to_s+':'+age.to_s+':'+Digest::SHA2.new(256).hexdigest( Digest::MD5.hexdigest(password)))
  
        return 'INGURU '+ Base64.strict_encode64([Digest::SHA2.new(256).hexdigest(login), time.to_s, age.to_s, hash].join(':')).to_s
    end

    def self.headers
        return {
            'Authorization': self.token,
            'Content-Type': 'application/json'
        }
    end

    def self.regions(region_id, district_id)
        params = {
            q: :kladr,
            region: region_id, 
            district: district_id
        }
        response = RestClient.get(URL, self.headers.merge({params: params}))

        return JSON.parse(response.body)['results']
    end

    def self.offer(sk, agreement)
        body = {
            sk: [sk.to_i]
        }
        agreement.each do |attr_name, attr_value|
            body[attr_name] = attr_value
        end
        response = RestClient::Request.execute(
            url: URL, 
            method: :post,
            payload: body.to_json, 
            headers: self.headers,
            timeout: 120
        )

        return JSON.parse(response.body)
    end

    def self.prev_calculate(params)
        body = {
			vehicle: params[:vehicle],
			multidrive: params[:multidrive],
			exactCalculation: params[:exactCalculation],
			drivers: params[:drivers],
			owner: params[:owner],
			usePeriod: params[:usePeriod]
        }
        response = RestClient.post(URL, body.to_json, self.headers)
        
        return JSON.parse(response.body)
    end

    def self.full_calculate(params)
        body = {
			:sk               => params[:sk],
			:vehicle          => {
				:type         =>  params[:vehicle][:type],
				:power        =>  params[:vehicle][:power],
				:year         =>  params[:vehicle][:year],
				:vin          =>  params[:vehicle][:vin],
				:docType      =>  params[:vehicle][:docType],
				:docSerial    =>  params[:vehicle][:docSerial],
				:docNumber    =>  params[:vehicle][:docNumber],
				:docDate      =>  params[:vehicle][:docDate],
				:brand        =>  params[:vehicle][:brand],
				:model        =>  params[:vehicle][:model],
				:dc           =>  params[:vehicle][:dc],
				:dcDate       =>  params[:vehicle][:dcDate],
				:dcIssueDate  =>  params[:vehicle][:dcIssueDate]
			},
			:multidrive         =>  params[:multidrive],
			:drivers            =>  params[:drivers],
			:owner              =>  {
				:lastname       =>  params[:owner][:lastname],
				:firstname      =>  params[:owner][:firstname],
				:middlename     =>  params[:owner][:middlename],
				:birthdate      =>  params[:owner][:birthdate],
				:passportSerial =>  params[:owner][:passportSerial],
				:passportNumber =>  params[:owner][:passportNumber],
				:name           =>  params[:owner][:name],
				:inn            =>  params[:owner][:inn],
				:docSerial      =>  params[:owner][:docSerial],
				:docNumber      =>  params[:owner][:docNumber],
				:city           =>  params[:owner][:city],
				:street         =>  params[:owner][:street],
				:house          =>  params[:owner][:house],
				:apartment      =>  params[:owner][:apartment],
				:fullkladr      =>  params[:owner][:fullkladr],
				:zip            =>  params[:owner][:zip],
				:fullAddress    =>  params[:owner][:fullAddress]
			},
			:usePeriod         =>  params[:usePeriod],
			:insurerIsOwner    =>  params[:insurerIsOwner],
			:purpose           =>  params[:purpose],
			:licensePlate      =>  params[:licensePlate],
			:registeredAbroad  =>  params[:registeredAbroad],
			:registrationWay   =>  params[:registrationWay],
			:useTrailer        =>  params[:useTrailer],
			:violations        =>  params[:violations],
			:date              =>  params[:date],
			:phone             =>  params[:phone],
			:email             =>  params[:email],
			:name              =>  params[:name]
		}
        response = RestClient::Request.execute(
            url: URL, 
            method: :post,
            payload: body.to_json, 
            headers: self.headers,
            timeout: 120
        )
        
        return {calculations: JSON.parse(response.body)}
    end

    def self.full_calculate_ins(params)
        body =  {
            :sk               => params[:sk],
            :vehicle          => {
                :type         =>  params[:vehicle][:type],
                :power        =>  params[:vehicle][:power],
                :year         =>  params[:vehicle][:year],
                :vin          =>  params[:vehicle][:vin],
                :docType      =>  params[:vehicle][:docType],
                :docSerial    =>  params[:vehicle][:docSerial],
                :docNumber    =>  params[:vehicle][:docNumber],
                :docDate      =>  params[:vehicle][:docDate],
                :brand        =>  params[:vehicle][:brand],
                :model        =>  params[:vehicle][:model],
                :dc           =>  params[:vehicle][:dc],
                :dcDate       =>  params[:vehicle][:dcDate],
                :dcIssueDate  =>  params[:vehicle][:dcIssueDate]
            },
            :multidrive         =>  params[:multidrive],
            :drivers            =>  params[:drivers],
            :owner              =>  {
                :lastname       =>  params[:owner][:lastname],
                :firstname      =>  params[:owner][:firstname],
                :middlename     =>  params[:owner][:middlename],
                :birthdate      =>  params[:owner][:birthdate],
                :passportSerial =>  params[:owner][:passportSerial],
                :passportNumber =>  params[:owner][:passportNumber],
                :name           =>  params[:owner][:name],
                :inn            =>  params[:owner][:inn],
                :docSerial      =>  params[:owner][:docSerial],
                :docNumber      =>  params[:owner][:docNumber],
                :city           =>  params[:owner][:city],
                :street         =>  params[:owner][:street],
                :house          =>  params[:owner][:house],
                :apartment      =>  params[:owner][:apartment],
                :fullkladr      =>  params[:owner][:fullkladr],
                :zip            =>  params[:owner][:zip],
                :fullAddress    =>  params[:owner][:fullAddress]
            },
            :usePeriod         =>  params[:usePeriod],
            :insurerIsOwner    =>  params[:insurerIsOwner],
            :insurer              =>  {
                :lastname       =>  params[:insurer][:lastname],
                :firstname      =>  params[:insurer][:firstname],
                :middlename     =>  params[:insurer][:middlename],
                :birthdate      =>  params[:insurer][:birthdate],
                :passportSerial =>  params[:insurer][:passportSerial],
                :passportNumber =>  params[:insurer][:passportNumber],
                :city           =>  params[:insurer][:city],
                :street         =>  params[:insurer][:street],
                :house          =>  params[:insurer][:house],
                :apartment      =>  params[:insurer][:apartment],
                :fullkladr      =>  params[:insurer][:fullkladr],
                :zip            =>  params[:insurer][:zip],
                :fullAddress    =>  params[:insurer][:fullAddress]
            },
            :purpose           =>  params[:purpose],
            :licensePlate      =>  params[:licensePlate],
            :registeredAbroad  =>  params[:registeredAbroad],
            :registrationWay   =>  params[:registrationWay],
            :useTrailer        =>  params[:useTrailer],
            :violations        =>  params[:violations],
            :date              =>  params[:date],
            :phone             =>  params[:phone],
            :email             =>  params[:email],
            :name              =>  params[:name]
        }
        response = RestClient::Request.execute(
            url: URL, 
            method: :post,
            payload: body.to_json, 
            headers: self.headers,
            timeout: 120
        )
        
        return {calculations: JSON.parse(response.body)}
    end

    def self.qeid(q, eid)
        params = {
            q: q,
            eId: eid
        }
        response = RestClient.get(URL, self.headers.merge({params: params}))

        return JSON.parse(response.body)
    end

    def self.brands
        params = {
            q: :list_brands,
        }
        response = RestClient.get(URL, self.headers.merge({params: params}))

        return JSON.parse(response.body)['results']
    end

    def self.models(brand)
        params = {
            q: :list_models,
            brand: brand
        }
        response = RestClient.get(URL, self.headers.merge({params: params}))

        return JSON.parse(response.body)['results']
    end
end