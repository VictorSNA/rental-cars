class CarRental < ApplicationRecord
  belongs_to :car
  belongs_to :rental

  validates :daily_rate, presence: {message: 'não pode ficar vazio'}
  validates :start_mileage, presence: {message: 'não pode ficar vazio'}
end
