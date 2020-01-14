require 'rails_helper'

feature 'Admin delete subsidiary' do
    scenario 'successfully' do
        user = User.create!(email: 'teste@teste.com', password: '123456')
        Subsidiary.create!(name: 'Jabaquara', cnpj: '00.000.000/0000-00', address: 'Avenue Jabaquara')

        login_as(user, scope: :user)
        visit root_path
        click_on 'Filiais'
        click_on 'Jabaquara'
        
        click_on 'Deletar'
        
        expect(page).to have_content('Filial excluída com sucesso')
    end
end