require 'rails_helper'

describe Car do
  describe '#full_description' do
    it 'should create a full description of car' do
      manufacturer = create(:manufacturer, name: 'Renault')
      car_model = create(:car_model,
                         name: 'Kwid', year: '2020', manufacturer: manufacturer,
                         motorization: '1.0', fuel_type: 'Flex')
      car = create(:car,
                   license_plate: 'ABC1234', color: 'Branco',
                   car_model: car_model)
      result = car.full_description

      expect(result).to eq 'Renault Kwid - ABC1234 - Branco'
    end
  end
end
