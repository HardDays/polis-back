Rails.application.routes.draw do
  namespace 'api'do
    namespace 'v1' do

      # Токен для INGURU
      get 'app/auth', action: :auth, controller: 'application'

      # Пока просто выгрузка в таблицы
      get 'cars/update', action: :update_cars, controller: 'application'

      post 'cars', action: :list, controller: 'cars'
      get 'cars/brand', action: :brands, controller: 'cars'
      get 'cars/brand/:id', action: :brand, controller: 'cars'
      get 'cars/model', action: :models, controller: 'cars'
      get 'cars/model/:id', action: :model, controller: 'cars'

      get 'insurance', action: :list, controller: 'insurance'
      get 'insurance/:id', action: :show, controller: 'insurance'

      get 'cars/type', action: :list, controller: 'cartype'
      get 'cars/type/:id', action: :show, controller: 'cartype'

      get 'cars/usetype', action: :list, controller: 'usetype'
      get 'cars/usetype/:id', action: :show, controller: 'usetype'

      post 'calculate/lite', action: :first_calc, controller: 'calculation'
      post 'calculate/full', action: :full_calc, controller: 'calculation'

      get 'pay/link/:eId', action: :pay_link, controller: 'pay'
      get 'pay/status/:eId', action: :pay_status, controller: 'pay'

      get 'polis/:eId', action: :polis_document, controller: 'application'

      get 'regions/', action: :regions, controller: 'application'
      get 'regions/:regId', action: :regions, controller: 'application'
      get 'regions/:regId/:distId', action: :regions, controller: 'application'

    end
  end

end
