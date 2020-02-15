class CarModel < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :car_category
  has_many :cars, dependent: :destroy

  validates :name, :year, :manufacturer_id, :motorization,
            :car_category_id, :fuel_type, presence: true
  validates :name, length: { maximum: 64 }
  validates :year, length: { maximum: 4 }
  validates :motorization, length: { maximum: 3 }
  validates :fuel_type, length: { maximum: 64 }
end
