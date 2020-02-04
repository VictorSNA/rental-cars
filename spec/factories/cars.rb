FactoryBot.define do
  sequence :license_plate do |n|
    "ABC#{(n).to_s.rjust(4, '0')}"
  end

  factory :car do
    license_plate
    color { 'Branco' }
    mileage { 1_000 }
    car_model
  end
end
