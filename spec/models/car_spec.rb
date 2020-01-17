require 'rails_helper'

RSpec.describe Car, type: :model do
  describe '#full_description' do
    it 'should create a full description of car' do
      manufacturer = Manufacturer.create!(name: 'Renault')
      car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54, car_insurance: 28,
                                         third_party_insurance: 10)
      car_model = CarModel.create!(name: 'Kwid', year: '2020', manufacturer: manufacturer,
                                   motorization: '1.0', car_category: car_category,
                                   fuel_type: 'Flex')
      car = Car.create!(license_plate: 'ABC1234', color: 'Branco', car_model: car_model,
                        mileage: 10000)
      result = car.full_description

      expect(result).to eq 'Renault Kwid - ABC1234 - Branco'
    end
  end
end
