module Helper

  def self.getINGURUToken
      login = 'test@inguru.ru'
      password = '123'
      age = 60*60*24
      time = Time.now.to_i
      hash =  Digest::MD5.hexdigest(login+':'+time.to_s+':'+age.to_s+':'+Digest::SHA2.new(256).hexdigest( Digest::MD5.hexdigest(password)))

      return 'INGURU '+Base64.strict_encode64([Digest::SHA2.new(256).hexdigest(login), time.to_s, age.to_s, hash].join(':')).to_s
  end

  def self.api_url
    return 'https://api.inguru.ru/eosago/4.0'
  end

  def self.getWidgetToken

    options = [
      {
        :username => "paramonov.kirill.alexandrovich@gmail.com",
        :password => "pH3xkXTp1"
      },
      {
        :username => "kka@pro-brokers.ru",
        :password => "kka@pro"
      },
      {
        :username => "kka@pro-brokers.ru",
        :password => "kka@pro"
      },
      {
        :username => "paramonov.kirill.alexandrovich@gmail.com",
        :password => "pH3xkXTp1"
      }
    ]
    # if DateTime.now.strftime('%s').to_i / 2 == 0
    #   body[:username] = "paramonov.kirill.alexandrovich@gmail.com"
    #   body[:password] = "pH3xkXTp1"
    # else
    #   body[:username] = "kka@pro-brokers.ru"
    #   body[:password] = "kka"
    # end

    # return body

      response = RestClient.post self.api_widget_url.to_s+'/users/obtain-token', options[rand(0..3)].to_json, {'Accept':'application/json, text/plain', 'Content-Type':'application/json'}
      # return response
      return 'Token ' + JSON.parse(response.body)['token']
  end

  def self.api_widget_url
    return 'https://widget.agentapp.ru/widgets/v1'
  end

  def self.dadata_url
    return 'https://dadata.ru/api/v2/suggest/address'
  end

  def self.dadata_token
    return 'Token 9dcb3624e329cc370178091ba4b82b28060b8c54'
    #return 'Token 42f86217e754ff52c35eb5175e36bac5b5c99b07'
  end

  def self.dadata_url_for_city
    return 'https://suggestions.dadata.ru/suggestions/api/4_1/rs/findById/address'
  end

end
