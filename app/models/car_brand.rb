class CarBrand < ApplicationRecord
  has_many :car_models

  validates :title, presence: :true
end
