require 'rails_helper'

feature 'Admin deletes manufacturer' do
    scenario 'successfully' do
        Manufacturer.create!(name: 'Volkswagen')

        visit root_path
        click_on 'Fabricantes'
        click_on 'Volkswagen'
        click_on 'Deletar'

        expect(page).to have_content('Fabricante excluído com sucesso')
    end

end