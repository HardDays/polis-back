class Car < ApplicationRecord

   # belongs_to :car_brand
   # belongs_to :car_model
   # belongs_to :car_type
   # belongs_to :car_usetype

   has_one :owner
   has_one :insurer
   has_many :drivers

   # validates :car_type_id, :car_brand_id, :car_model_id, :owner_id, :power, :year, :body_number, :vin

end
