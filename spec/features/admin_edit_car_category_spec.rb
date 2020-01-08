require 'rails_helper'

feature 'Admin edit Car Category' do
    scenario 'successfully' do
        CarCategory.create!(name:'Sedã', daily_rate: 30, car_insurance: 300, third_party_insurance: 300)
        visit root_path
        
        click_on 'Categorias de carro'
        click_on 'Sedã'
        click_on 'Editar'

        fill_in 'Nome', with: 'SUV compacto'
        click_on 'Enviar'

        expect(page).to have_content('Editado com sucesso')
        expect(page).to have_content('SUV compacto')
    end

end