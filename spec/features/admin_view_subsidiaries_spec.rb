require 'rails_helper'

feature 'Admin view subsidiaries' do
    scenario 'successufully' do
        Subsidiary.create!(name: 'Saúde', cnpj: '00.000.000/0000-00', address: 'Avenue Jabaquara, 1469')
        
        visit root_path
        click_on 'Filiais'
        click_on 'Saúde'

        expect(page).to have_content('Saúde')
        expect(page).to have_content('00.000.000/0000-0')
        expect(page).to have_content('Avenue Jabaquara, 1469')
    end

    scenario ' and return to home page' do
        Subsidiary.create!(name: 'Saúde', cnpj: '00.000.000/0000-00', address: 'Avenue Jabaquara, 1469')

        visit root_path
        click_on 'Filiais'
        click_on 'Saúde'
        click_on 'Home'
        
        expect(current_path).to eq root_path

    end

end