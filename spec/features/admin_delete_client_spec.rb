require 'rails_helper'

feature 'Admin delete client' do
  scenario 'sucessfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    Client.create!(name: 'Fulano da Silva', cpf: '127.587.748-60',
                            email: 'fulanodasilva@teste.com')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Clientes'
    click_on 'Fulano da Silva'
    click_on 'Deletar'

    expect(page).to have_content('Cliente excluído com sucesso')
  end
end