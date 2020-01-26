class Client < ApplicationRecord
  has_many :rentals

  validates :name, :email, :cpf, presence: {message: 'não pode ficar vazio'}
  validates :name, length: {maximum: 64, message: 'muito grande'}
  validates :email, length: {maximum: 128, message: 'muito grande'}
  validates :cpf, length: {maximum: 14, message: 'muito grande'}
  def identification
    "#{cpf} - #{name}"
  end
end
