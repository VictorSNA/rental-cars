require 'rails_helper'

feature 'Admin edit manufacturer' do
  scenario 'successfully' do
    Manufacturer.create(name: 'Fiat')
    user = User.create!(email: 'teste@teste.com', password: '123456')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Honda')
  end

  scenario 'and must be unique' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    login_as(user, scope: :user)

    Manufacturer.create(name: 'Fiat')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar fabricante'
    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fornecedor já cadastrado')
  end

  scenario 'and fields must be filled' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar fabricante'

    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar vazio')
  end

  scenario 'and must be authenticated to edit' do
    visit edit_manufacturer_path(00000)

    expect(current_path).to eq(new_user_session_path)
  end
end