require 'rails_helper'

describe 'Rental Management' do
  context 'create' do
    it 'must create a rental successfully' do
      user = User.create!(email: 'teste@teste.com', password: '123456')
      manufacturer = Manufacturer.create!(name: 'Fiat')
      client = Client.create!(name: 'Fulano da Silva', cpf: '127.587.748-60',
                              email: 'fulanodasilva@teste.com')
      car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54,
                                         car_insurance: 28,
                                         third_party_insurance: 10)
      car_model = CarModel.create!(name: 'Kwid', year: '2020',
                                   manufacturer: manufacturer,
                                   motorization: '1.0',
                                   car_category: car_category,
                                   fuel_type: 'Flex')
      Car.create!(license_plate: 'ABC1234', color: 'Branco',
                  car_model: car_model, mileage: 10_000, status: 0)
      post api_v1_rentals_path, params: {
        start_date: Date.current,
        end_date: 1.day.from_now,
        client_id: client.id,
        car_category_id: car_category.id,
        user_id: user.id
      }

      expect(response).to have_http_status(:ok)
    end

    it 'must create a rental and check for a valid car' do
      allow(Car).to receive(:all).and_return(Car.none)
      allow(Rental).to receive(:all).and_return(Rental.none)
      user = User.create!(email: 'teste@teste.com', password: '123456')
      client = Client.create!(name: 'Fulano da Silva', cpf: '127.587.748-60',
                              email: 'fulanodasilva@teste.com')
      car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54,
                                         car_insurance: 28,
                                         third_party_insurance: 10)
      post api_v1_rentals_path, params: {
        start_date: Date.current,
        end_date: 1.day.from_now,
        client_id: client.id,
        car_category_id: car_category.id,
        user_id: user.id
      }
      expect(response).to have_http_status 412
    end
  end
end
