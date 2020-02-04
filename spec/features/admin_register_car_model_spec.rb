require 'rails_helper'

feature 'Admin register Car Model' do
  scenario 'successfully' do
    user = create(:user)
    create(:manufacturer, name: 'Chevrolet')
    create(:car_category, name: 'AM')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Registrar modelo de carro'
    fill_in 'Nome', with: 'Onix Hatch'
    fill_in 'Ano', with: '2019'
    select 'Chevrolet', from: 'Fabricante'
    fill_in 'Motorização', with: '1.4'
    select 'AM', from: 'Categoria de carro'
    fill_in 'Tipo de combustível', with: 'Flex'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'MODELO:')
    expect(page).to have_css('h2', text: 'Onix Hatch')
    expect(page).to have_css('h3', text: 'Detalhes:')
    expect(page).to have_css('p', text: 'Ano: 2019')
    expect(page).to have_css('p', text: 'Fabricante: Chevrolet')
    expect(page).to have_css('p', text: 'Motorização: 1.4')
    expect(page).to have_css('p', text: 'Categoria: AM')
    expect(page).to have_css('p', text: 'Tipo de combustível: Flex')
  end

  scenario 'and must be authenticated to register' do
    visit new_car_model_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and fields must be present' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_car_model_path
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Ano não pode ficar em branco')
    expect(page).to have_content('Motorização não pode ficar em branco')
    expect(page).to have_content('Tipo de combustível não pode ficar em branco')
    expect(page).to have_content('Fabricante não pode ficar em branco')
    expect(page).to have_content('Categoria de carro não pode ficar em branco')
  end

  scenario 'and name must be less or equal to 64' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_car_model_path
    fill_in 'Nome', with: 'a' * 65

    click_on 'Enviar'

    expect(page).to have_content('Nome é muito longo (máximo: 64 caracteres')
  end

  scenario 'and year must be less or equal to 4' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_car_model_path
    fill_in 'Ano', with: '1' * 5
    click_on 'Enviar'

    expect(page).to have_content('Ano é muito longo (máximo: 4 caracteres)')
  end

  scenario 'and motorization must be less or equal to 3' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_car_model_path
    fill_in 'Motorização', with: '1' * 4
    click_on 'Enviar'

    expect(page).to have_content('Motorização é muito longo '\
                                 '(máximo: 3 caracteres)')
  end

  scenario 'and fuel type must be less or equal to 64' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_car_model_path
    fill_in 'Tipo de combustível', with: '1' * 65
    click_on 'Enviar'

    expect(page).to have_content('Tipo de combustível é muito longo '\
                                 '(máximo: 64 caracteres)')
  end
end
