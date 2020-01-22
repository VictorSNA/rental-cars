class CarCategory < ApplicationRecord
    has_many :car_models
    has_many :rentals
    validates :name, presence: {message: 'Nome não pode ficar vazio'}
    validates :daily_rate, presence: {message: 'Diária não pode ficar vazio'},
                        numericality: {greater_than: 0}
    validates :car_insurance, presence: {message: 'Seguro do automóvel não pode ficar vazio'},
                        numericality: {greater_than: 0}
    validates :third_party_insurance,
                        presence: {message: 'Seguro contra terceiros não pode ficar vazio'},
                        numericality: {greater_than: 0}

    
end
