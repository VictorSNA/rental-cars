require 'rails_helper'

feature 'Admin deletes subsidiary' do
    scenario 'successfully' do
        Subsidiary.create!(name: 'Jabaquara', cnpj: '00.000.000/0000-00', address: 'Avenue Jabaquara')

        visit root_path
        click_on 'Filiais'
        click_on 'Jabaquara'
        
        click_on 'Deletar'
        
        expect(page).to have_content('Filial excluída com sucesso')
    end
end