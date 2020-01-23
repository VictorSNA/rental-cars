class CarRental < ApplicationRecord
  belongs_to :car
  belongs_to :rental

  validates :daily_rate, presence: {message: 'não pode ficar vazio'}
  validates :start_mileage, presence: {message: 'não pode ficar vazio'}
  validates :car_insurance, presence: {message: 'não pode ficar vazio'}
  validates :third_party_insurance, presence: {message: 'não pode ficar vazio'}

  def daily_rate_total
    (daily_rate + car_insurance + third_party_insurance).round(2)
  end
end
