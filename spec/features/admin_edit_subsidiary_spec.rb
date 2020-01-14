require 'rails_helper'

feature 'Admin edit subsidiary' do
    scenario 'successfully' do
        user = User.create!(email: 'teste@teste.com', password: '123456')
        Subsidiary.create!(name:'Saúde', cnpj:'00.000.000/0000-00', address:'Avenue Jabaquara')
        
        login_as(user, scope: :user)
        visit root_path
        click_on 'Filiais'
        click_on 'Saúde'
        click_on 'Editar'

        fill_in 'Nome', with: 'Paraíso'
        fill_in 'CNPJ', with: '00.000.000/0000-01'
        fill_in 'Endereço', with: 'Avenue Paraíso'

        click_on 'Enviar'

        expect(page).to have_content('Paraíso')
        expect(page).to have_content('00.000.000/0000-01')
        expect(page).to have_content('Avenue Paraíso')
    end

    scenario 'and must be authenticate to edit' do
        visit edit_subsidiary_path(00000)

        expect(current_path).to eq(new_user_session_path)
    end
end
