require 'rails_helper'

feature 'Admin register subsidiary' do
    scenario 'successfully' do
        visit root_path
        click_on 'Filiais'
        click_on 'Cadastrar Filial'

        fill_in 'Nome', with: 'Paraíso'
        fill_in 'CNPJ', with: '00.000.000/0000-01'
        fill_in 'Endereço', with: 'Avenue Paraíso'
        
        click_on 'Enviar'

        expect(page).to have_content('Paraíso')
        expect(page).to have_content('00.000.000/0000-01')
        expect(page).to have_content('Avenue Paraíso')
    end
    
    scenario 'and fields can not be blank' do
        visit root_path
        click_on 'Filiais'
        click_on 'Cadastrar Filial'
        click_on 'Enviar'

        expect(page).to have_content('Você deve corrigir o(s) seguinte(s) erro(s)')
        expect(page).to have_content('Name não pode estar vazio')
        expect(page).to have_content('Cnpj não pode estar vazio')
        expect(page).to have_content('Address não pode estar vazio')
    end

    scenario 'can not be duplicated' do
        Subsidiary.create!(name: 'Paraíso', cnpj: '00.000.000/0000-01', address: 'Avenue Paraíso')

        visit root_path
        click_on 'Filiais'
        click_on 'Cadastrar Filial'
        
        fill_in 'Nome', with: 'Paraíso'
        fill_in 'CNPJ', with: '00.000.000/0000-01'
        fill_in 'Endereço', with: 'Avenue Paraíso'
        
        click_on 'Enviar'
        
        expect(page).to have_content('Filial já está cadastrada')
    end

    scenario 'cnpj cannot be invalid' do
        visit root_path
        click_on 'Filiais'
        click_on 'Cadastrar Filial'

        fill_in 'Nome', with: 'Paraíso'
        fill_in 'CNPJ', with: '00000000000'

        click_on 'Enviar'
        
        expect(page).to have_content('CNPJ Inválido')
    end
end