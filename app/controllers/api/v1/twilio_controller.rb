#require 'twilio-ruby'
#require 'rest'
module Api
    module V1
        class TwilioController < ApplicationController

            def verify     
               render json: TwilioHelper.verify(params) , status: :ok
            end

            def check
                render json: TwilioHelper.check(params) , status: :ok
            end
        end
    end
end