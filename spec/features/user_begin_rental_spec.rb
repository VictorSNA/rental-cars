require 'rails_helper'

feature 'User begin rental' do
  scenario 'and view all avaliable cars before' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    manufacturer = Manufacturer.create!(name: 'Renault')
    car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54, car_insurance: 28,
                                       third_party_insurance: 10)
    another_car_category = CarCategory.create!(name: 'A', daily_rate: 46.54, car_insurance: 28,
                                       third_party_insurance: 10)
    car_model = CarModel.create!(name: 'Kwid', year: '2020', manufacturer: manufacturer,
                                 motorization: '1.0', car_category: car_category,
                                 fuel_type: 'Flex')
    another_car_model = CarModel.create!(name: 'Sandero', year: '2019', manufacturer: manufacturer,
                                 motorization: '1.6', car_category: another_car_category,
                                 fuel_type: 'Flex')
    client = Client.create!(name: 'Fulano da Silva', cpf: '127.587.748-60',
                            email: 'fulanodasilva@teste.com')
    Rental.create!(code: 'VKN0001', start_date: Date.current, end_date: 1.day.from_now,
    client: client, car_category: car_category, user: user)
    Car.create!(license_plate: 'ABC1234', color: 'Branco', car_model: car_model,
                mileage: 10000, status: 0)
    Car.create!(license_plate: 'DEF5678', color: 'Azul', car_model: another_car_model,
                mileage: 10000, status: 0)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'
    click_on 'VKN0001'

    expect(page).to have_content('Selecionar o carro')
    expect(page).to have_content('Renault Kwid - ABC1234 - Branco')
    expect(page).not_to have_content('Renault Sandero - DEF5678 - Azul')

  end

  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    manufacturer = Manufacturer.create!(name: 'Renault')
    car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54, car_insurance: 28,
                                       third_party_insurance: 10)
    car_model = CarModel.create!(name: 'Kwid', year: '2020', manufacturer: manufacturer,
                                 motorization: '1.0', car_category: car_category,
                                 fuel_type: 'Flex')
    client = Client.create!(name: 'Fulano da Silva', cpf: '127.587.748-60',
                            email: 'fulanodasilva@teste.com')
    Rental.create!(code: 'VKN0001', start_date: Date.current, end_date: 1.day.from_now,
    client: client, car_category: car_category, user: user)
    car = Car.create!(license_plate: 'ABC1234', color: 'Branco', car_model: car_model,
                mileage: 10000, status: 0)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'
    click_on 'VKN0001'
    within "#div-#{car.id}" do
      click_on 'Iniciar'
    end

    expect(page).to have_content('Locação - VKN0001')
    expect(page).to have_content('Iniciado com sucesso')
    expect(page).to have_content('Carro')
    expect(page).to have_content('Renault Kwid - ABC1234 - Branco')
    expect(page).to have_content('Cliente')
    expect(page).to have_content('Fulano da Silva')
    expect(page).to have_content('Usuário')
    expect(page).to have_content('teste@teste.com')
  end

  scenario 'and unavaliable cars must be blocked via button' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    manufacturer = Manufacturer.create!(name: 'Renault')
    car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54, car_insurance: 28,
                                       third_party_insurance: 10)
    car_model = CarModel.create!(name: 'Kwid', year: '2020', manufacturer: manufacturer,
                                 motorization: '1.0', car_category: car_category,
                                 fuel_type: 'Flex')
    client = Client.create!(name: 'Fulano da Silva', cpf: '127.587.748-60',
                            email: 'fulanodasilva@teste.com')
    Rental.create!(code: 'VKN0001', start_date: Date.current, end_date: 1.day.from_now,
    client: client, car_category: car_category, user: user)
    Car.create!(license_plate: 'ABC1234', color: 'Branco', car_model: car_model,
                mileage: 10000, status: 0)
    Car.create!(license_plate: 'DEF5678', color: 'Azul', car_model: car_model,
                mileage: 10000, status: 5)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'
    click_on 'VKN0001'

    expect(page).to have_content('ABC1234')
    expect(page).not_to have_content('DEF5678')
  
  end
end