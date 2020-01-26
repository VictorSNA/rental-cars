require 'rails_helper'

feature 'Admin delete client' do
  scenario 'sucessfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    client = Client.create!(name: 'Fulano da Silva', cpf: '127.587.748-60',
                            email: 'fulanodasilva@teste.com')
    login_as(user, scope: :user)

    visit clients_path
    click_on 'Fulano da Silva'
    click_on 'Editar'
    fill_in 'Nome', with: 'Fulano Sicrano'
    click_on 'Enviar'

    expect(page).to have_content('Cliente editado com sucesso')
    expect(page).to have_content('Fulano Sicrano')
  end
end