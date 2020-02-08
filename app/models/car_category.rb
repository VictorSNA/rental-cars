class CarCategory < ApplicationRecord
    has_many :car_models
    has_many :rentals
    validates :name, presence: true,
                     uniqueness: { case_sensitive: false },
                     length: { maximum: 32 }
    validates :daily_rate, presence: true,
                        numericality: { greater_than: 0, less_than_or_equal_to: 1000000 }
    validates :car_insurance, presence: true,
                              numericality:
                              { greater_than: 0,
                                less_than_or_equal_to: 1000000 }
    validates :third_party_insurance, presence: true,
                                      numericality:
                                      { greater_than: 0,
                                        less_than_or_equal_to: 1_000_000 }
end
