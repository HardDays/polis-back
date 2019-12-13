# файл переименовать в amo_helper.rb, везде файлы доожны быть в одном стиле

module AmoHelper
    API_URL = 'https://goodluckclub.amocrm.ru/api/v2'
    PRIVATE_API_URL = 'https://goodluckclub.amocrm.ru/private/api'

    def self.test2(params)

        response = RestClient::Request.execute(method: :post,
            url:  "#{PRIVATE_API_URL}/auth.php?type=json",
            payload: {
                'USER_LOGIN': 'mm@goodluck-club.ru',
                'USER_HASH': '2f9ec387539d0e3c1a83bd0759c0ea3b824957dd'
            }.to_json,
            headers: {
            },
            timeout: 120
        )

        result = {};

        response_acc = RestClient::Request.execute(method: :get,
            url: "#{API_URL}/account?with=custom_fields,note_types,pipelines",
            headers: {
                :cookies => {:session_id => response.cookies["session_id"]}
            },
            timeout: 120
        )

        id = 23
        aggr = Agreement.find id
        body = {
            "add" => []
        }

        model = {
            "status_id" => 30041410,
            "name" => "back_api_test_" + aggr["id"].to_s,
            "custom_fields" => [
                {
            		"id" => 282877,
	                "values" => [
	                    {
	                        "value" => 404827
	                    }
	                ]
                },
                {
            		"id" => 282879,
	                "values" => [
	                    {
	                        "value" => 404829
	                    }
	                ]
                },
                {
            		"id" => 282881,
	                "values" => [
	                    {
	                        "value" => 404835
	                    }
	                ]
                },
                {
            		"id" => 282883,
	                "values" => [
	                    {
	                        "value" => 404837
	                    }
	                ]
            	},
                {
            		"id" => 282885,
	                "values" => [
	                    {
	                        "value" => 404841
	                    }
	                ]
                },
                {
            		"id" => 282889,
	                "values" => [
	                    {
	                        "value" => aggr.date.iso8601
	                    }
	                ]
                },
                {
            		"id" => 282901,
	                "values" => [
	                    {
	                        "value" => 400000
	                    }
	                ]
                },
                {
            		"id" => 327473,
	                "values" => [
	                    {
	                        "value" => 463813
	                    }
	                ]
                },
                {
            		"id" => 327535,
	                "values" => [
	                    {
	                        "value" => aggr.licensePlate
	                    }
	                ]
            	}
            ]
        }

        # return Car.find aggr["car_id"]
        if aggr["car_id"]
            car = Car.find aggr["car_id"]
            # return car
            model["custom_fields"].push({
                "id" => 282899,
                "values" => [
                    {
                        "value" => car.brand + " " + car.model + ", " + car.power.to_s + " л.с."
                    }
                ]
            })

            model["custom_fields"].push({
                "id" => 327517,
                "values" => [
                    {
                        "value" => car.dcDate.iso8601
                    }
                ]
            })

            model["custom_fields"].push({
                "id" => 327527,
                "values" => [
                    {
                        "value" => car.year.to_i
                    }
                ]
            })

            result["car"] = car
        end

        body["add"].push model

        result["body"] = body

        result["aggr"] = aggr


        response2 = RestClient::Request.execute(method: :post,
            url: "#{API_URL}/leads",
            payload: body.to_json,
            headers: {
                :cookies => {:session_id => response.cookies["session_id"]}
            },
            timeout: 120)

        result["response_leed"] = JSON.parse response2.body

        # return 
        leed_id = result["response_leed"]["_embedded"]["items"][0]["id"]
        notes = {
            "add" => []
        }

        notes["add"].push({
            "element_id" => leed_id.to_s,
            "element_type" => "2",
            "note_type" => 4,
            "text" => "agreement => " + JSON.pretty_generate(JSON.parse(aggr.to_json))
        })

        if result["car"]
            notes["add"].push({
                "element_id" => leed_id.to_s,
                "element_type" => "2",
                "note_type" => 4,
                "text" => "car => " + JSON.pretty_generate(JSON.parse(result["car"].to_json))
            })
        end

        if aggr["owner_id"]
            owner = Owner.find aggr["owner_id"]
            notes["add"].push({
                "element_id" => leed_id.to_s,
                "element_type" => "2",
                "note_type" => 4,
                "text" => "owner => " + JSON.pretty_generate(JSON.parse(owner.to_json))
            })
        end

        if aggr["insurer_id"]
            insurer = Insurer.find aggr["insurer_id"]
            notes["add"].push({
                "element_id" => leed_id.to_s,
                "element_type" => "2",
                "note_type" => 4,
                "text" => "insurer => " + JSON.pretty_generate(JSON.parse(insurer.to_json))
            })
        end

        response3 = RestClient::Request.execute(method: :post,
            url: "#{API_URL}/notes",
            payload: notes.to_json,
            headers: {
                :cookies => {:session_id => response.cookies["session_id"]}
            },
            timeout: 120)

        result["response_nodes"] = JSON.parse response3.body

        return result
    end

    def self.all_agreements
        result = [];
        Agreement.find_each do |user|
            model = {}

            user.attributes.each do |attr_name, attr_value|
                model[attr_name] = attr_value
            end

            if model["car_id"]
                model[:vehicle] = Car.find model["car_id"]
            end
        
            if model["owner_id"]
                model[:owner] = Owner.find model["owner_id"]
            end
        
            if model["insurer"]
                model[:insurer] = Insurer.find model["insurer"]
            end
        
            model[:drivers] = Driver.where(agreement_id: model["id"])

            result.push model
        end

        return result
    end
end