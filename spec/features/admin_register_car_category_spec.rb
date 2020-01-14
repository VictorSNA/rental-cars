require 'rails_helper'

feature 'Admin register Car Category' do
    scenario 'sucessfully' do
        visit root_path
        click_on 'Categorias de carro'
        click_on 'Cadastrar categoria de carro'

        fill_in 'Nome', with: 'Sedã'
        fill_in 'Diária', with: 30
        fill_in 'Seguro do automóvel', with: 300
        fill_in 'Seguro contra terceiros', with: 250

        click_on 'Enviar'

        expect(page).to have_content('Sedã')
        expect(page).to have_content(30)
        expect(page).to have_content(300)
        expect(page).to have_content(250)

    end

    scenario 'and fields must be filled' do
        visit root_path

        click_on 'Categorias de carro'
        click_on 'Cadastrar categoria de carro'

        click_on 'Enviar'

        expect(page).to have_content('Nome não pode ficar vazio')
        expect(page).to have_content('Diária não pode ficar vazio')
        expect(page).to have_content('Seguro do automóvel não pode ficar vazio')
        expect(page).to have_content('Seguro contra terceiros não pode ficar vazio')

    end
end