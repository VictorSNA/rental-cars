require 'rails_helper'

describe 'Car model management' do
  context 'delete' do

    it 'successfully' do
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_category = CarCategory.create!(name: 'A', daily_rate: 36.5,
                                         car_insurance: 32.90,
                                         third_party_insurance: 30.90)
      car_model = CarModel.create!(name: 'Onix hatch', year: '2019', motorization: '1.4',
                                   fuel_type: 'Flex', manufacturer: manufacturer,
                                   car_category: car_category)
      delete car_model_path(car_model)
      
      expect(flash[:notice]).to include 'Modelo de carro excluído com sucesso'
    end
    it 'should delete a car model that exists' do
      delete car_model_path(0)

      expect(flash[:alert]).to include 'Você não pode fazer essa ação'
    end
    it 'successfully via API' do
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_category = CarCategory.create!(name: 'A', daily_rate: 36.5,
                                         car_insurance: 32.90,
                                         third_party_insurance: 30.90)
      car_model = CarModel.create!(name: 'Onix hatch', year: '2019', motorization: '1.4',
                                   fuel_type: 'Flex', manufacturer: manufacturer,
                                   car_category: car_category)
      delete api_v1_car_model_path(car_model)
      
      expect(response).to have_http_status :ok
    end

    it 'should delete a car model that exists via API' do
      delete api_v1_car_model_path(0)
      
      expect(response).to have_http_status 404
    end
  end
end