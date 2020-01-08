require 'rails_helper'

feature 'Admin register Car Model' do
    scenario 'successfully' do
        Manufacturer.create!(name: 'Chevrolet')
        CarCategory.create!(name:'Sedã compacto', daily_rate: 30, car_insurance:300,
                            third_party_insurance: 300)
        visit root_path
        click_on 'Modelos de carro'
        click_on 'Registrar modelo de carro'

        fill_in 'Nome', with: 'Onix Hatch'
        fill_in 'Ano', with: '2019'
        select 'Chevrolet', from: 'Fabricante'
        fill_in 'Motorização', with: '1.4'
        select 'Sedã compacto', from: 'Categoria de carro'
        fill_in 'Tipo de combustível', with: 'Flex'

        click_on 'Enviar'

        expect(page).to have_css('h1', text:'Onix Hatch')
        expect(page).to have_css('h3', text:'Detalhes')
        expect(page).to have_css('p', text:'2019')
        expect(page).to have_css('p', text:'Chevrolet')
        expect(page).to have_css('p', text:'1.4')
        expect(page).to have_css('p', text: 'Sedã compacto')
        expect(page).to have_css('p', text:'Flex')
    end

end