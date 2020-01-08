class Subsidiary < ApplicationRecord
    validates :name, :cnpj, :address, uniqueness: {message: 'Filial já está cadastrada'}
    validates :name, presence: {message: 'não pode estar vazio'}
    validates :cnpj, presence: {message: 'não pode estar vazio'}, 
    length: {is: 18, message: 'CNPJ Inválido'}, format: {with: /[0-9.&\/-]*/, message: 'Apenas números no CNPJ'}
    validates :address, presence: {message: 'não pode estar vazio'}
end
