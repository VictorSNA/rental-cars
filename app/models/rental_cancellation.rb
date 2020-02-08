class RentalCancellation < ApplicationRecord
  belongs_to :user
  belongs_to :rental
  belongs_to :car_rental
end
