class CarModel < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :car_category
  has_many :cars

  validates :name, :year, :manufacturer_id, :motorization,
            :car_category_id, :fuel_type, presence: {message: 'não pode ficar vazio'}
  validates :name, length: {maximum: 64, message: 'muito grande'}
  validates :year, length: {maximum: 4, message: 'muito grande'}
  validates :motorization, length: {maximum: 3, message: 'deve ser até 3 caracteres'}
  validates :fuel_type, length: {maximum: 64, message: 'deve ser até 64 caracteres'}
end
