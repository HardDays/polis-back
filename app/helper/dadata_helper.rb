module DadataHelper

    URL = 'https://dadata.ru/api/v2/suggest/address'
    SUGGEST_URL = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs/findById/address'
    UFMS_URL = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/fms_unit'

    HEADERS = {
        'Authorization': 'Token 9dcb3624e329cc370178091ba4b82b28060b8c54',
        'Content-Type': 'application/json'
    }

    def self.kladr(query, count)
        body = {
            count: count,
            from_bound: {
                value: :city
            },
            query: query,
            to_bound: {
                value: :settlement
            }
        }

        response = RestClient.post(URL, body.to_json, HEADERS)
        return JSON.parse(response.body)['suggestions']
    end

    def self.kladr_city(query)
        body = {
            query: query,
            to_bound: {
                value: :settlement
            }
        }

        response = RestClient.post(SUGGEST_URL, body.to_json, HEADERS)
        return JSON.parse(response.body)['suggestions']
    end

    def self.addr(query, count, kladr_id)
        body = {
            count: count,
            query: query,
            locations: [
                {
                    kladr_id: kladr_id
                },
            ],
            restrict_value: true
        }

        response = RestClient.post(URL, body.to_json, HEADERS)
        return JSON.parse(response.body)['suggestions']
    end

    def self.ufms(query, count)
        body = {
            count: count,
            query: query,
        }

        response = RestClient.post(UFMS_URL, body.to_json, HEADERS)
        return JSON.parse(response.body)['suggestions']
    end

end