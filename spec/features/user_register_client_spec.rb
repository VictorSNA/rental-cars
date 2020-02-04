require 'rails_helper'

feature 'User register client' do
  scenario 'successfully' do
    user = create(:user)

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
    user = create(:user)

    login_as(user, scope: :user)
    visit new_client_path
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Email não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
  end

  scenario 'and name must be less or equal to 64' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_client_path
    fill_in 'Nome', with: 'a' * 65
    click_on 'Enviar'

    expect(page).to have_content('Nome é muito longo (máximo: 64 caracteres)')
  end

  scenario 'and name must be less or equal to 128' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_client_path
    fill_in 'Email', with: 'a' * 129
    click_on 'Enviar'

    expect(page).to have_content('Email é muito longo (máximo: 128 caracteres)')
  end

  scenario 'and CPF must be equal to 14' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_client_path
    fill_in 'CPF', with: 'a' * 13
    click_on 'Enviar'

    expect(page).to have_content('CPF não possui o tamanho esperado '\
                                 '(14 caracteres)')
  end
end
