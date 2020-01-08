class Manufacturer < ApplicationRecord
    has_many :car_models
    validates :name , presence:{message: 'Você deve preencher o campo Nome'}, uniqueness:{message: 'Fornecedor já cadastrado'}
end
