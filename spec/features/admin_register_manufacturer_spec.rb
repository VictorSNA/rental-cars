require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar fabricante'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fabricante registrado com sucesso')
    expect(page).to have_content('Fiat')
  end

  scenario 'and must be unique' do
    user = create(:user)
    create(:manufacturer, name: 'Fiat')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar fabricante'
    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and must be unique and case sensitive' do
    user = create(:user)
    create(:manufacturer, name: 'Fiat')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar fabricante'
    fill_in 'Nome', with: 'fiat'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and fields must be filled' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar fabricante'

    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and must be authenticated to register' do
    visit new_manufacturer_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and name length must be lesser than 64 characters' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_manufacturer_path

    fill_in 'Nome', with: 'a' * 65
    click_on 'Enviar'

    expect(page).to have_content('Nome é muito longo (máximo: 64 caracteres)')
  end
end
