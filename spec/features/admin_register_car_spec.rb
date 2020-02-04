require 'rails_helper'

feature 'Admin register car' do
  scenario 'successfully' do
    user = create(:user)
    manufacturer = create(:manufacturer, name: 'Renault')
    create(:car_model, name: 'Kwid', manufacturer: manufacturer)

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
    user = create(:user)

    login_as(user, scope: :user)
    visit new_car_path
    click_on 'Enviar'

    expect(page).to have_content('Placa não pode ficar em branco')
    expect(page).to have_content('Cor não pode ficar em branco')
    expect(page).to have_content('Quilometragem não pode ficar em branco')
    expect(page).to have_content('Modelo de carro não pode ficar em branco')
  end

  scenario 'and license plate must be unique' do
    user = create(:user)
    create(:car, license_plate: 'DEF5678')

    login_as(user, scope: :user)
    visit new_car_path
    fill_in 'Placa', with: 'DEF5678'
    click_on 'Enviar'

    expect(page).to have_content('Placa já está em uso')
  end

  scenario 'and mileage must be greater or equal to zero' do
    user = create(:user)

    login_as(user, scope: :user)

    visit new_car_path

    fill_in 'Quilometragem', with: -12.90
    click_on 'Enviar'

    expect(page).to have_content('Quilometragem deve ser maior ou igual a 0')
  end
end
