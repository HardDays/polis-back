class CarModel < ApplicationRecord
   belongs_to :car_brand

   validates :title, presence: :true
   validates :car_brand_id, presence: :true
end
