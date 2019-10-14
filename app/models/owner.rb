class Owner < ApplicationRecord

  belongs_to :car

  validate :city_id

end
