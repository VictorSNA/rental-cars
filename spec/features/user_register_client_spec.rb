require 'rails_helper'

feature 'User register client' do
  scenario 'successfully' do
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

end