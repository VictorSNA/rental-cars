FactoryBot.define do
  factory :car_model do
    name { 'Kwid' }
    year { '2020' }
    motorization { '1.0' }
    fuel_type { 'Flex' }
    manufacturer
    car_category
  end
end
