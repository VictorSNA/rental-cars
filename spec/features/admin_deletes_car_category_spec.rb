require 'rails_helper'

feature 'Admin deletes car category' do
    scenario 'successfully' do
        CarCategory.create!(name:'Sedã',daily_rate:30,car_insurance: 300, third_party_insurance: 300)

        visit root_path
        click_on 'Categorias de carro'
        click_on 'Sedã'
        click_on 'Deletar'

        expect(page).to have_content('Excluído com sucesso')
    end
end