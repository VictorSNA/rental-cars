require 'rails_helper'

feature 'Admin edit manufacturer' do
  scenario 'successfully' do
    user = create(:user)
    create(:manufacturer, name: 'Fiat')

    login_as(user, scope: :user)

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Fabricante editado com sucesso')
    expect(page).to have_content('Honda')
  end

  scenario 'and must be unique' do
    user = create(:user)
    login_as(user, scope: :user)

    manufacturer = create(:manufacturer, name: 'Fiat')
    create(:manufacturer, name: 'Honda')

    visit edit_manufacturer_path(manufacturer)
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and must be unique and case sensitive' do
    user = create(:user)
    login_as(user, scope: :user)

    manufacturer = create(:manufacturer, name: 'Fiat')
    create(:manufacturer, name: 'Honda')

    visit edit_manufacturer_path(manufacturer)
    fill_in 'Nome', with: 'honda'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and fields must be filled' do
    user = create(:user)
    manufacturer = create(:manufacturer, name: 'Honda')

    login_as(user, scope: :user)

    visit edit_manufacturer_path(manufacturer)
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and must be authenticated to edit' do
    visit edit_manufacturer_path(0)

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and name length must be lesser than 64 characters' do
    user = create(:user)
    manufacturer = create(:manufacturer, name: 'Fiat')

    login_as(user, scope: :user)
    visit edit_manufacturer_path(manufacturer)
    fill_in 'Nome', with: 'a' * 65
    click_on 'Enviar'

    expect(page).to have_content('Nome é muito longo (máximo: 64 caracteres)')
  end
end
