class Subsidiary < ApplicationRecord
  has_many :rentals, dependent: :destroy
  has_many :users
  validates :name, :cnpj, :address, uniqueness: { case_sensitive: false },
                                    presence: true
  validates :name, length: { maximum: 64 }
  validates :cnpj, length: { is: 18 },
  format: { with: /[0-9.&\/-]*/, message: 'Apenas números'\
                                              'no CNPJ' }
  validates :address, length: { maximum: 128 }
end
