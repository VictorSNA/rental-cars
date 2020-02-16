require 'rails_helper'

feature 'Admin view Car Model' do
  scenario 'successfully' do
    user = create(:user)
    manufacturer = create(:manufacturer, name: 'Chevrolet')
    car_category = create(:car_category, name: 'AM')
    car_model = create(:car_model,
                       name: 'Onix hatch', year: '2019',
                       manufacturer: manufacturer, motorization: '1.4',
                       car_category: car_category, fuel_type: 'Flex')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    click_on car_model.name

    expect(page).to have_css('h1', text: 'MODELO:')
    expect(page).to have_css('h2', text: 'Onix hatch')
    expect(page).to have_css('h3', text: 'Detalhes:')
    expect(page).to have_css('p', text: 'Ano: 2019')
    expect(page).to have_css('p', text: 'Fabricante: Chevrolet')
    expect(page).to have_css('p', text: 'Motorização: 1.4')
    expect(page).to have_css('p', text: 'Categoria: AM')
    expect(page).to have_css('p', text: 'Tipo de combustível: Flex')
  end

  scenario 'and must be authenticated via button' do
    visit root_path

    expect(page).not_to have_content('Modelos de carro')
  end

  scenario 'and must be authenticated via route' do
    visit car_models_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated to view details' do
    visit car_model_path(0)

    expect(current_path).to eq(new_user_session_path)
  end
end
