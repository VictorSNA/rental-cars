require 'rails_helper'

feature 'User view client' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    Client.create!(name: 'Victor', cpf: '000.000.000-00', email: 'teste@gmail.com')
    login_as(user, scope: :user)
    visit root_path

    click_on 'Clientes'

    expect(page).to have_content('Victor')
    expect(page).to have_content('000.000.000-00')
    expect(page).to have_content('teste@gmail.com')
  end

  scenario 'and must be authenticated via button' do
    visit root_path

    expect(page).not_to have_content('Clientes')
  end

  scenario 'and must be authenticated via route' do
    visit clients_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated to view details' do
    visit client_path(00000)

    expect(current_path).to eq(new_user_session_path)
  end
end