class Accessory < ApplicationRecord
  has_many :accessory_rentals
  has_many :rentals, through: :accessory_rentals
end
