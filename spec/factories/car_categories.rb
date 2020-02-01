FactoryBot.define do
  factory :car_category do
    name { 'AM' }
    daily_rate { 46.54 }
    car_insurance { 28 }
    third_party_insurance { 10 }
  end
end
