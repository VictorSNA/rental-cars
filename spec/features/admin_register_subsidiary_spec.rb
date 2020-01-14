require 'rails_helper'

feature 'Admin register subsidiary' do
    scenario 'successfully' do
        user = User.create!(email: 'teste@teste.com', password: '123456')

        login_as(user, scope: :user)
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
    
    scenario 'and fields must be filled' do
        user = User.create!(email: 'teste@teste.com', password: '123456')

        login_as(user, scope: :user)
        visit root_path
        click_on 'Filiais'
        click_on 'Cadastrar Filial'
        click_on 'Enviar'

        expect(page).to have_content('Você deve corrigir o(s) seguinte(s) erro(s)')
        expect(page).to have_content('Name não pode estar vazio')
        expect(page).to have_content('Cnpj não pode estar vazio')
        expect(page).to have_content('Address não pode estar vazio')
    end

    scenario 'and must be unique' do
        Subsidiary.create!(name: 'Paraíso', cnpj: '00.000.000/0000-01', address: 'Avenue Paraíso')
        user = User.create!(email: 'teste@teste.com', password: '123456')

        login_as(user, scope: :user)
        visit root_path
        click_on 'Filiais'
        click_on 'Cadastrar Filial'
        
        fill_in 'Nome', with: 'Paraíso'
        fill_in 'CNPJ', with: '00.000.000/0000-01'
        fill_in 'Endereço', with: 'Avenue Paraíso'
        
        click_on 'Enviar'
        
        expect(page).to have_content('Filial já está cadastrada')
    end

    scenario 'field CNPJ must be valid' do
        user = User.create!(email: 'teste@teste.com', password: '123456')

        login_as(user, scope: :user)
        visit root_path
        click_on 'Filiais'
        click_on 'Cadastrar Filial'

        fill_in 'Nome', with: 'Paraíso'
        fill_in 'CNPJ', with: '00000000000'

        click_on 'Enviar'
        
        expect(page).to have_content('CNPJ Inválido')
    end

    scenario 'and must be authenticated to register' do
        visit new_subsidiary_path

        expect(current_path).to eq(new_user_session_path)

    end
end