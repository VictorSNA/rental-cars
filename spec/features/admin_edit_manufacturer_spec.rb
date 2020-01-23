require 'rails_helper'

feature 'Admin edit manufacturer' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    Manufacturer.create!(name: 'Fiat')
    
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
    user = User.create!(email: 'teste@teste.com', password: '123456')
    login_as(user, scope: :user)

    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Honda')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Fornecedor já cadastrado')
  end

  scenario 'and fields must be filled' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    Manufacturer.create!(name: 'Honda')

    login_as(user, scope: :user)

    visit root_path
    click_on 'Fabricantes'
    click_on 'Honda'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar vazio')
  end

  scenario 'and must be authenticated to edit' do
    visit edit_manufacturer_path(00000)

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and name length must be lesser than 64 characters' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    manufacturer =Manufacturer.create!(name: 'Fiat')

    login_as(user, scope: :user)
    visit edit_manufacturer_path(manufacturer)
    fill_in 'Nome', with: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    click_on 'Enviar'

    expect(page).to have_content('Name muito grande')
  end
end