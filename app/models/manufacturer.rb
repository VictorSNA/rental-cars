class Manufacturer < ApplicationRecord
    has_many :car_models
    validates :name , presence: true,
                      uniqueness:{ case_sensitive: false },
                      length: { maximum: 64 }
end
