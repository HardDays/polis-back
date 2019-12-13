module AgentappHelper

    URL = 'https://widget.agentapp.ru/widgets/v1'
    
    LOGIN_PATH = '/users/b2c-login'
    FIND_PATH = '/insured_objects/cars/by_number_plate'
    TICKET_CHECK_PATH = '/insured_objects/cars/ticket_check'

    def self.token
        headers = {
            'Accept': 'application/json, text/plain', 
            'B2C-DOMAIN': 'widget.agentapp.ru'
        }
        response = RestClient.post(URL + LOGIN_PATH, nil, headers)
        return 'Token ' + JSON.parse(response.body)['token']
    end

    def self.headers
        return {
            'Accept': 'application/json, text/plain, */*', 
            'Content-Type': 'application/json', 
            'Authorization': self.token
        }
    end

    def self.find_car(number_plate)
        body = {
			number_plate: number_plate
        }
        response = RestClient.post(URL + FIND_PATH, body.to_json, self.headers)
        
        return JSON.parse(response.body)
    end

    def self.ticket_check(ident_type, ident_number)
        body = {
            ident_type: ident_type,
            ident_number: ident_number
        }
        response = RestClient.post(URL + TICKET_CHECK_PATH, body.to_json, self.headers)

        return JSON.parse(response.body)

    end

end