require 'rails_helper'


feature 'Admin edit subsidiary' do
    scenario 'successfully' do
        Subsidiary.create!(name:'Saúde', cnpj:'00.000.000/0000-00', address:'Avenue Jabaquara')
        
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
end
