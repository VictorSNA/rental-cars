require 'rails_helper'

feature 'Admin edit car model' do
  scenario 'successfully' do
    manufacturer = Manufacturer.create!(name: 'Chevrolet')
    Manufacturer.create!(name: 'Fiat')
    car_category = CarCategory.create!(name: 'Sedã compacto', daily_rate: 30,
                                      car_insurance: 300, third_party_insurance: 300)
    CarCategory.create!(name: 'Sedã', daily_rate: 20,
                      car_insurance: 280, third_party_insurance: 280)
    CarModel.create!(name: 'Onix hatch', year: '2019', manufacturer: manufacturer,
                                motorization: '1.4', car_category: car_category, 
                                fuel_type: 'Flex')

    visit root_path
    click_on 'Modelos de carro'
    click_on 'Onix hatch'
    click_on 'Editar'

    fill_in 'Nome', with: 'Uno'
    fill_in 'Ano', with: '2020'
    select 'Fiat', from: 'Fabricante'
    fill_in 'Motorização', with: '2.0'
    select 'Sedã', from: 'Categoria de carro'
    fill_in 'Tipo de combustível', with: 'Álcool'
    click_on 'Enviar'
    
    expect(page).to have_content('Uno')
    expect(page).to have_content('2020')
    expect(page).to have_content('Fiat')
    expect(page).to have_content('2.0')
    expect(page).to have_content('Sedã')
    expect(page).to have_content('Álcool')
    
  end
end