class Manufacturer < ApplicationRecord
    has_many :car_models
    validates :name , presence:{message: 'Nome não pode ficar vazio'},
                      uniqueness:{message: 'Fornecedor já cadastrado'},
                      length: {maximum: 64, message: "muito grande"}
end
