FactoryBot.define do
  factory :car do
    license_plate { 'ABC1234' }
    color { 'Branco' }
    mileage { 1_000 }
    car_model
  end
end
