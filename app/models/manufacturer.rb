class Manufacturer < ApplicationRecord
    has_many :car_models
    validates :name , presence:{message: 'Nome não pode ficar vazio'},
                      uniqueness:{message: 'Fornecedor já cadastrado', case_sensitive: false},
                      length: {maximum: 64, message: "muito grande"}
end
