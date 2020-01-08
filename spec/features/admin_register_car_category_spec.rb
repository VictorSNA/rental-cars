require 'rails_helper'

feature 'Admin register Car Category' do
    scenario 'sucessfully' do
        visit root_path
        click_on 'Categorias de carro'
        click_on 'Cadastrar categoria de carro'

        fill_in 'Nome', with: 'Sedã'
        fill_in 'Diária', with: 30
        fill_in 'Seguro do carro', with: 300
        fill_in 'Seguro contra terceiros', with: 250

        click_on 'Enviar'

        expect(page).to have_content('Sedã')
        expect(page).to have_content(30)
        expect(page).to have_content(300)
        expect(page).to have_content(250)

    end

    scenario 'Fields cannot be blank' do
        visit root_path

        click_on 'Categorias de carro'
        click_on 'Cadastrar categoria de carro'

        click_on 'Enviar'

        expect(page).to have_content('Name não pode estar vazio')
        expect(page).to have_content('Daily rate não pode estar vazio')
        expect(page).to have_content('Car insurance não pode estar vazio')
        expect(page).to have_content('Third party insurance não pode estar vazio')

    end
end