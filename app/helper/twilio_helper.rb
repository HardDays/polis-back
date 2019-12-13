require 'twilio-ruby'

module TwilioHelper

    SERVICE_KEY = 'VA30c92d81b2f81cad82b5abc9094f0cef'

    SID = 'AC62f6b5ad1a010ad31550f9337c18a324'
    TOKEN = '09f689ef28badfa49b92033fcc45f51f'

    def self.verify(params)
        
        client = Twilio::REST::Client.new(SID, TOKEN)

        verification = client.verify
            .services(SERVICE_KEY)
            .verifications
            .create(to: params['phone'].to_s, channel: 'sms')

        insurer = Insurer.where(phone:params['phone'].to_s).take
        if !insurer.nil?
            insurer = Insurer.new(phone:params['phone'].to_s)
            insurer.save
        end

        return {
           :sid => verification.sid,
           :to => verification.to,
           :status => verification.status
        }.to_json
    end

    def self.check(params)
        
        client = Twilio::REST::Client.new(SID, TOKEN)

        verification = client.verify
            .services(SERVICE_KEY)
            .verification_checks
            .create(to: params['phone'].to_s, code: params['code'].to_s)

        return {
            :sid => verification.sid,
            :to => verification.to,
            :status => verification.status
        }.to_json
    end
end
  