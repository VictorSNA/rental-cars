class CarCategory < ApplicationRecord
    has_many :car_models
    validates :name, :daily_rate, :car_insurance, :third_party_insurance,
    presence: {message: 'não pode estar vazio'}
end
