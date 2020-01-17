class RentalsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :search]
  def index
    client = Client.create!(name: 'Fulano da Silva', cpf: '127.587.748-60',
                            email: 'fulanodasilva@teste.com')
    car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54, car_insurance: 28,
                                       third_party_insurance: 10)
    Rental.create!(code: 'VKN0001', start_date: Date.current, end_date: 1.day.from_now,
                   client: client, car_category: car_category)
  end
  def search
    @rentals = Rental.where('code LIKE ?', "%#{params[:q]}%")
    
  end
end