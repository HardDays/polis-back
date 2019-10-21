require 'twilio-ruby'
module TwilioHelper
    def self.verify(params)
        
        get_client
        # return {:success => @client.to_s}.to_json
        verification = @client.verify
            .services('VA30c92d81b2f81cad82b5abc9094f0cef')
            .verifications
            .create(to: params['phone'].to_s, channel: 'sms')

        return {
           :sid => verification.sid,
           :to => verification.to,
           :status => verification.status
        }.to_json
    end

    def self.check(params)
        get_client
        verification = @client.verify
            .services('VA30c92d81b2f81cad82b5abc9094f0cef')
            .verification_checks
            .create(to: params['phone'].to_s, code: params['code'].to_s)

        return {
            :sid => verification.sid,
            :to => verification.to,
            :status => verification.status
        }.to_json
    end

    private 
    def self.get_client
        account_sid = 'AC62f6b5ad1a010ad31550f9337c18a324'
        auth_token = '09f689ef28badfa49b92033fcc45f51f'
        @client = ::Twilio::REST::Client.new account_sid, auth_token
        # return @client
    end
    



end
  