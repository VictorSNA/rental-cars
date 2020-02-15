class Manufacturer < ApplicationRecord
  has_many :car_models, dependent: :destroy
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { maximum: 64 }
end
