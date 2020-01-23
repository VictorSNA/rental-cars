require 'rails_helper'

describe 'Rental Management' do
  context 'create' do
    it 'must create a rental successfully' do
      user = User.create!(email: 'teste@teste.com', password: '123456')
      client = Client.create!(name: 'Fulano da Silva', cpf: '127.587.748-60',
                              email: 'fulanodasilva@teste.com')
      car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54, car_insurance: 28,
                                         third_party_insurance: 10)

      post '/api/v1/rentals', params: {start_date: Date.current, end_date: 1.day.from_now,
                                       client_id: client.id, car_category_id: car_category.id,
                                       user_id: user.id}
      
      expect(response).to have_http_status(:ok)
    end
  end
end