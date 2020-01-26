class Client < ApplicationRecord
  has_many :rentals

  validates :name, :email, :cpf, presence: {message: 'não pode ficar vazio'}
  validates :name, length: {maximum: 64, message: 'muito grande'}
  validates :email, length: {maximum: 128, message: 'muito grande'}
  validates :cpf, length: {is: 14, message: 'inválido'}
  def identification
    "#{cpf} - #{name}"
  end
end
