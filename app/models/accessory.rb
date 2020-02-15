class Accessory < ApplicationRecord
  has_many :accessory_rentals, dependent: :destroy
  has_many :rentals, through: :accessory_rentals
end
