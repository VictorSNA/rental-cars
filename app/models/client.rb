class Client < ApplicationRecord
  has_many :rentals, dependent: :destroy

  validates :name, :email, :cpf, presence: true
  validates :name, length: { maximum: 64 }
  validates :email, length: { maximum: 128 }
  validates :cpf, length: { is: 14 }

  def identification
    "#{cpf} - #{name}"
  end
end
