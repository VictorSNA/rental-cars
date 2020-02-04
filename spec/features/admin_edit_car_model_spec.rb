require 'rails_helper'

feature 'Admin edit car model' do
  scenario 'successfully' do
    user = create(:user)
    create(:manufacturer, name: 'Hyundai')
    create(:car_category, name: 'BM')
    create(:car_model, name: 'Onix hatch')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Onix hatch'
    click_on 'Editar'

    fill_in 'Nome', with: 'Uno'
    fill_in 'Ano', with: '2020'
    select 'Hyundai', from: 'Fabricante'
    fill_in 'Motorização', with: '2.0'
    select 'BM', from: 'Categoria de carro'
    fill_in 'Tipo de combustível', with: 'Álcool'
    click_on 'Enviar'

    expect(page).to have_content('Uno')
    expect(page).to have_content('2020')
    expect(page).to have_content('Hyundai')
    expect(page).to have_content('2.0')
    expect(page).to have_content(/BM/)
    expect(page).to have_content('Álcool')
  end

  scenario 'and must be authenticated to edit' do
    visit edit_car_model_path(0)

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and fields must be present' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    car_model = create(:car_model)

    login_as(user, scope: :user)
    visit edit_car_model_path(car_model)
    fill_in 'Nome', with: ''
    fill_in 'Ano', with: ''
    fill_in 'Motorização', with: ''
    fill_in 'Tipo de combustível', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Ano não pode ficar em branco')
    expect(page).to have_content('Motorização não pode ficar em branco')
    expect(page).to have_content('Tipo de combustível não pode ficar em branco')
  end
end
