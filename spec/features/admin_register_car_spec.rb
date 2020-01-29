require 'rails_helper'

feature 'Admin register car' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    manufacturer = Manufacturer.create!(name: 'Renault')
    car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54,
                                       car_insurance: 28,
                                       third_party_insurance: 10)
    car_model = CarModel.create!(name: 'Kwid', year: '2020',
                                 manufacturer: manufacturer,
                                 motorization: '1.0', 
                                 car_category: car_category,
                                 fuel_type: 'Flex')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'Cadastrar carro'

    fill_in 'Placa', with: 'ABC1234'
    fill_in 'Cor', with: 'Branco'
    select 'Kwid', from: 'Modelo de carro'
    fill_in 'Quilometragem', with: 100.83
    click_on 'Enviar'

    expect(page).to have_content('Carro registrado com sucesso')
    expect(page).to have_content('Renault Kwid - ABC1234 - Branco')
    expect(page).to have_content('Quilometragem')
    expect(page).to have_content(100.83)

  end

  scenario 'and all fields must be filled' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    manufacturer = Manufacturer.create!(name: 'Renault')
    car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54,
                                       car_insurance: 28,
                                       third_party_insurance: 10)
    login_as(user, scope: :user)

    visit new_car_path
    click_on 'Enviar'
    
    expect(page).to have_content('Placa não pode ficar vazio')
    expect(page).to have_content('Cor não pode ficar vazio')
    expect(page).to have_content('Quilometragem não pode ficar vazio')
    expect(page).to have_content('Modelo de carro não pode ficar vazio')

  end

  scenario 'and license plate must be unique' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    manufacturer = Manufacturer.create!(name: 'Renault')
    car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54,
                                       car_insurance: 28,
                                       third_party_insurance: 10)
    car_model = CarModel.create!(name: 'Kwid', year: '2020',
                                 manufacturer: manufacturer,
                                 motorization: '1.0',
                                 car_category: car_category,
                                 fuel_type: 'Flex')
    Car.create!(license_plate: 'DEF5678', color: 'Azul', car_model: car_model,
                mileage: 10000, status: 0)
    login_as(user, scope: :user)

    visit new_car_path
    fill_in 'Placa', with: 'DEF5678'
    fill_in 'Cor', with: 'Branco'
    select 'Kwid', from: 'Modelo de carro'
    fill_in 'Quilometragem', with: 100.83
    click_on 'Enviar'
    
    expect(page).to have_content('Placa já cadastrada')

  end

  scenario 'and mileage must be greater or equal to zero' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    manufacturer = Manufacturer.create!(name: 'Renault')
    car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54,
                                       car_insurance: 28,
                                       third_party_insurance: 10)
    car_model = CarModel.create!(name: 'Kwid', year: '2020',
                                 manufacturer: manufacturer,
                                 motorization: '1.0',
                                 car_category: car_category,
                                 fuel_type: 'Flex')
    
    login_as(user, scope: :user)
    
    visit new_car_path
    fill_in 'Placa', with: 'DEF5678'
    fill_in 'Cor', with: 'Branco'
    select 'Kwid', from: 'Modelo de carro'
    fill_in 'Quilometragem', with: -12.90
    click_on 'Enviar'

    expect(page).to have_content('Mileage must be greater than or equal to 0')
  end
end