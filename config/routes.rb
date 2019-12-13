Rails.application.routes.draw do
  namespace 'api'do
    namespace 'v1' do
      
      #TOOD: переименовать роуты на чуть более логичные, сгруппировать по контроллерам

      #get 'cars/update', action: :update_cars, controller: 'cars'
      get 'cars/brand', action: :index, controller: 'car_brands'
      get 'cars/brand/:id', action: :show, controller: 'car_brands'

      get 'cars/model', action: :index, controller: 'car_models'
      get 'cars/model/:id', action: :show, controller: 'car_models'

      post 'cars', action: :index, controller: 'cars'
      post 'cars/by_number_plate', action: :create, controller: 'cars'
      #post 'cars/ticket_check', action: :ticket_check, controller: 'cars'

      get 'insurance', action: :list, controller: 'insurance'
      get 'insurance/:id', action: :show, controller: 'insurance'

      get 'cars/type', action: :list, controller: 'cartype'
      get 'cars/type/:id', action: :show, controller: 'cartype'

      get 'cars/usetype', action: :list, controller: 'usetype'
      get 'cars/usetype/:id', action: :show, controller: 'usetype'

      post 'calculate/full', action: :calculate, controller: 'calculation'
      post 'calculate/save', action: :create_agreement, controller: 'calculation'
      get 'calculate', action: :agreement, controller: 'calculation'
      #TODO: переименовать, ЗАПУТАННО БЛЯ
      post 'calculate/lite', action: :full_calculate, controller: 'inguru'
      post 'calculate/offer/:sk', action: :offer, controller: 'inguru'
      get 'app/auth', action: :auth, controller: 'inguru'
      get 'polis/:eId', action: :polis, controller: 'inguru'
      get 'pay/link/:eId', action: :pay_link, controller: 'inguru'
      get 'pay/status/:eId', action: :pay_status, controller: 'inguru'

      get 'addr/kladr', action: :kladr_city, controller: 'dadata'
      get 'regions/addr', action: :addr, controller: 'dadata'
      get 'regions/ufms', action: :ufms, controller: 'dadata'
      get 'regions/kladr', action: :kladr, controller: 'dadata'

      post 'twilio/verify', action: :verify, controller: 'twilio'
      post 'twilio/check', action: :check, controller: 'twilio'

      get 'amo/test', action: :amo, controller: 'apply'

    end
  end

end
