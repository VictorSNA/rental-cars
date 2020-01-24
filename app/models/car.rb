class Car < ApplicationRecord
  belongs_to :car_model
  has_one :car_rental
  
  enum status: {avaliable: 0, unavaliable: 5}, _prefix: :status
  
  validates :license_plate, presence: {message: 'Placa não pode ficar vazio'},
                            uniqueness: {message: 'Placa já cadastrada'}
  validates :color, presence: {message: 'Cor não pode ficar vazio'}
  validates :mileage, presence: {message: 'Quilometragem não pode ficar vazio'},
                      numericality: {greater_than_or_equal_to: 0}
  validates :car_model_id, presence: {message: 'Modelo de carro não pode ficar vazio'}

  def full_description
    "#{car_model.manufacturer.name} #{car_model.name} - #{license_plate} - #{color}"
  end
end
