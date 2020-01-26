require 'rails_helper'

feature 'User register client' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path

    click_on 'Clientes'
    click_on 'Registrar cliente'
    fill_in 'Nome', with: 'Victor'
    fill_in 'CPF', with: '000.000.000-00'
    fill_in 'Email', with: 'teste@gmail.com'
    click_on 'Enviar'

    expect(page).to have_content('Victor')
    expect(page).to have_content('000.000.000-00')
    expect(page).to have_content('teste@gmail.com')
  end

  scenario 'and must be authenticated via route' do
    visit new_client_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and fields must be present' do
    user = User.create!(email: 'teste@teste.com', password: '123456')

    login_as(user, scope: :user)
    visit new_client_path
    click_on 'Enviar'

    expect(page).to have_content('Name não pode ficar vazio')
    expect(page).to have_content('Email não pode ficar vazio')
    expect(page).to have_content('Cpf não pode ficar vazio')
  end

  scenario 'and name must be less or equal to 64' do
    user = User.create!(email: 'teste@teste.com', password: '123456')

    login_as(user, scope: :user)
    visit new_client_path
    fill_in 'Nome', with: 'a' * 65
    click_on 'Enviar'

    expect(page).to have_content('Name muito grande')
  end

  scenario 'and name must be less or equal to 128' do
    user = User.create!(email: 'teste@teste.com', password: '123456')

    login_as(user, scope: :user)
    visit new_client_path
    fill_in 'Email', with: 'a' * 129
    click_on 'Enviar'

    expect(page).to have_content('Email muito grande')
  end

  scenario 'and CPF must be equal to 14' do
    user = User.create!(email: 'teste@teste.com', password: '123456')

    login_as(user, scope: :user)
    visit new_client_path
    fill_in 'CPF', with: 'a' * 15
    click_on 'Enviar'

    expect(page).to have_content('Cpf muito grande')
  end
end