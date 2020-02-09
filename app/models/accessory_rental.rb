class AccessoryRental < ApplicationRecord
  belongs_to :accessory
  belongs_to :rental
end
