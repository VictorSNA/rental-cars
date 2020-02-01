FactoryBot.define do
  factory :car_rental do
    daily_rate { 30 }
    start_mileage { 20 }
    car_insurance { 30 }
    third_party_insurance { 300 }
    car
    rental
  end
end
