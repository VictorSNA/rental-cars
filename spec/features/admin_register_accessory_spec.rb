require 'rails_helper'

feature 'Admin register accessory' do
  scenario 'successfuly' do
    user = create(:user)

    login_as(user, scope: :user)

    visit root_path
    click_on 'Locações'
    click_on 'Acessórios'
    click_on 'Registrar acessório'
    fill_in 'Nome', with: 'Bebê conforto'
    fill_in 'Descrição', with: 'Obrigatório por lei para recém-nascidos'
    fill_in 'Diária', with: 13.99
    click_on 'Enviar'

    expect(page).to have_content('Acessório registrado com sucesso')
    expect(page).to have_content('Bebê conforto')
  end
end
