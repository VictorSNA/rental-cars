require 'rails_helper'

describe 'Car Management' do
  context 'show' do
    it 'render a json successfully' do
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_category = CarCategory.create!(name: 'A', daily_rate: 36.5,
                                         car_insurance: 32.90,
                                         third_party_insurance: 30.90)
      car_model = CarModel.create!(name: 'Onix hatch', year: '2019',
                                   motorization: '1.4',
                                   fuel_type: 'Flex',
                                   manufacturer: manufacturer,
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
      expect(response.body).to include "Couldn't find Car with 'id'=999"
    end
  end
  context 'index' do
    it 'must returns a list with multiple cars' do
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_category = CarCategory.create!(name: 'A', daily_rate: 36.5,
                                         car_insurance: 32.90,
                                         third_party_insurance: 30.90)
      car_model = CarModel.create!(name: 'Onix hatch', year: '2019',
                                   motorization: '1.4',
                                   fuel_type: 'Flex',
                                   manufacturer: manufacturer,
                                   car_category: car_category)
      car = Car.create!(car_model: car_model, license_plate: 'ABC1234',
                        color: 'Branco', mileage: 100.99)
      other_car = Car.create!(car_model: car_model, license_plate: 'DEF5678',
                              color: 'Prata', mileage: 50.99)

      get api_v1_cars_path

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)

      expect(json[0][:car_model_id]).to eq car.car_model.id
      expect(json[0][:license_plate]).to eq car.license_plate
      expect(json[0][:color]).to eq car.color
      expect(json[0][:mileage]).to eq '100.99'
      expect(json[1][:car_model_id]).to eq other_car.car_model.id
      expect(json[1][:license_plate]).to eq other_car.license_plate
      expect(json[1][:color]).to eq other_car.color
      expect(json[1][:mileage]).to eq '50.99'
    end
    it 'must only show index if any car exists' do
      get api_v1_cars_path
      expect(response).to have_http_status :not_found
    end
  end
  context 'create' do
    it 'successfully' do
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_category = CarCategory.create!(name: 'A', daily_rate: 36.5,
                                         car_insurance: 32.90,
                                         third_party_insurance: 30.90)
      car_model = CarModel.create!(name: 'Onix hatch', year: '2019',
                                   motorization: '1.4',
                                   fuel_type: 'Flex',
                                   manufacturer: manufacturer,
                                   car_category: car_category)

      post api_v1_cars_path, params: {
        license_plate: 'DBZ9090',
        color: 'Vermelho',
        mileage: 70.90,
        car_model_id: car_model.id
      }

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:license_plate]).to eq 'DBZ9090'
      expect(json[:color]).to eq 'Vermelho'
      expect(json[:mileage]).to eq '70.9'
      expect(json[:car_model_id]).to eq car_model.id
    end
    it 'if records not invalid' do
      post api_v1_cars_path, params: { banana: 'DBZ9090' }

      expect(response).to have_http_status(:precondition_failed)
    end
  end

  context 'edit' do
    it 'successfully' do
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_category = CarCategory.create!(name: 'A', daily_rate: 36.5,
                                         car_insurance: 32.90,
                                         third_party_insurance: 30.90)
      car_model = CarModel.create!(name: 'Onix hatch', year: '2019',
                                   motorization: '1.4',
                                   fuel_type: 'Flex',
                                   manufacturer: manufacturer,
                                   car_category: car_category)
      car = Car.create!(car_model: car_model, license_plate: 'ABC1234',
                        color: 'Branco', mileage: 100.99)
      patch api_v1_car_path(car), params: {
        license_plate: 'DBZ9090',
        color: 'Vermelho',
        mileage: 70.90,
        car_model_id: car_model.id
      }

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:license_plate]).to eq 'DBZ9090'
      expect(json[:color]).to eq 'Vermelho'
      expect(json[:mileage]).to eq '70.9'
      expect(json[:car_model_id]).to eq car_model.id
    end
  end
  context 'car_statuses' do
    it 'must switch car status to unavaliable' do
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_category = CarCategory.create!(name: 'A', daily_rate: 36.5,
                                         car_insurance: 32.90,
                                         third_party_insurance: 30.90)
      car_model = CarModel.create!(name: 'Onix hatch', year: '2019',
                                   motorization: '1.4',
                                   fuel_type: 'Flex',
                                   manufacturer: manufacturer,
                                   car_category: car_category)
      car = Car.create!(car_model: car_model, license_plate: 'ABC1234',
                        color: 'Branco', mileage: 100.99)

      patch api_v1_car_path(car), params: { status: 'unavaliable' }

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status :ok
      expect(json[:status]).to eq 'unavaliable'
    end

    it 'must switch car status to avaliable' do
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_category = CarCategory.create!(name: 'A', daily_rate: 36.5,
                                         car_insurance: 32.90,
                                         third_party_insurance: 30.90)
      car_model = CarModel.create!(name: 'Onix hatch', year: '2019',
                                   motorization: '1.4',
                                   fuel_type: 'Flex',
                                   manufacturer: manufacturer,
                                   car_category: car_category)
      car = Car.create!(car_model: car_model, license_plate: 'ABC1234',
                        color: 'Branco', mileage: 100.99, status: 5)

      patch api_v1_car_path(car), params: { status: 'avaliable' }

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status :ok
      expect(json[:status]).to eq 'avaliable'
    end
  end
end
