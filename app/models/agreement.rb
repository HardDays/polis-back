class Agreement < ApplicationRecord
    
    belongs_to :car, optional: true
    belongs_to :owner, optional: true
    belongs_to :insurer, optional: true

    has_many :drivers


    def as_json(options={})
        attrs = super
        if options && options[:details]
            attrs[:car] = car
            attrs[:owner] = owner
            attrs[:insurer] = insurer
            attrs[:drivers] = drivers
        end
    end

    #has_one :car, :owner
    # self.inheritance_column = :_type_disabled
    #validates :type, presence: :true
    #validates :power, presence: :true
    # validates :year, presence: :true
    # validates :docType, presence: :true
    # validates :brand, presence: :true
    # validates :model, presence: :true
    # validates :vin, uniqueness: true
 end