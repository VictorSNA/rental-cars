class CarCategory < ApplicationRecord
    has_many :car_models
    has_many :rentals
    validates :name, presence: {message: 'Nome não pode ficar vazio'},
                     uniqueness: {message: 'Categoria de carro já cadastrado', case_sensitive: false},
                     length: {maximum: 32, message: 'muito grande'}
                    
    validates :daily_rate, presence: {message: 'Diária não pode ficar vazio'},
                        numericality: {greater_than: 0, less_than_or_equal_to: 1000000}
    validates :car_insurance, presence: {message: 'Seguro do automóvel não pode ficar vazio'},
                        numericality: {greater_than: 0, less_than_or_equal_to: 1000000}
    validates :third_party_insurance,
                        presence: {message: 'Seguro contra terceiros não pode ficar vazio'},
                        numericality: {greater_than: 0, less_than_or_equal_to: 1000000}

    
end
