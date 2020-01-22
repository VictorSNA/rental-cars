require 'rails_helper'

describe 'Car Management' do
  context 'show' do
    it 'renders a json successfully' do
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_category = CarCategory.create!(name: 'A', daily_rate: 36.5,
                                         car_insurance: 32.90,
                                         third_party_insurance: 30.90)
      car_model = CarModel.create!(manufacturer: manufacturer,
                                   car_category: car_category)
      car = Car.create!(car_model: car_model, license_plate: 'ABC1234',
                        color: 'Branco', mileage: 100.99)
      
      get api_v1_car_path(car)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:car_model_id]).to eq car.car_model.id
      expect(json[:license_plate]).to eq car.license_plate
      expect(json[:color]).to eq car.color
      expect(json[:mileage]).to eq car.mileage.to_s
    end

    it 'must not return cars that not exits' do
      get api_v1_car_path(999)

      expect(response).to have_http_status(:not_found)
    end
  end
end