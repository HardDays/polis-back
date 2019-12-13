class Car < ApplicationRecord
   self.inheritance_column = :_type_disabled
   #validates :type, presence: :true
   validates :power, presence: :true
   validates :year, presence: :true
   validates :docType, presence: :true
   validates :brand, presence: :true
   validates :model, presence: :true
   validates :vin, uniqueness: true
end
