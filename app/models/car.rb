class Car < ApplicationRecord
  belongs_to :car_model
  has_one :car_rental, dependent: :destroy

  enum status: { avaliable: 0, unavaliable: 5 }, _prefix: :status

  validates :license_plate, :color, :mileage, :car_model_id,
            presence: true
  validates :license_plate, uniqueness: true
  validates :mileage, numericality: { greater_than_or_equal_to: 0 }

  def full_description
    "#{car_model.manufacturer.name} #{car_model.name} - #{license_plate} - "\
    "#{color}"
  end
end
