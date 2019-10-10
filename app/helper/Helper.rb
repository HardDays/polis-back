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

end
