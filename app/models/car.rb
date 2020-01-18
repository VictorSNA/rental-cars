class Car < ApplicationRecord
  enum status: {avaliable: 0, unavaliable: 5}, _prefix: :status
  belongs_to :car_model

  def full_description
    "#{car_model.manufacturer.name} #{car_model.name} - #{license_plate} - #{color}"
  end
end
