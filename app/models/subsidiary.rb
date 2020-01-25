class Subsidiary < ApplicationRecord
    validates :name, :cnpj, :address, uniqueness: {message: 'Filial já está cadastrada', case_sensitive: false}
    validates :name, presence: {message: 'não pode estar vazio'},
                     length: {maximum: 64, message: 'muito grande'}
    validates :cnpj, presence: {message: 'não pode estar vazio'}, 
    length: {is: 18, message: 'CNPJ Inválido'}, format: {with: /[0-9.&\/-]*/, message: 'Apenas números no CNPJ'}
    validates :address, presence: {message: 'não pode estar vazio'},
                        length: {maximum: 128, message: 'muito grande'}
end
