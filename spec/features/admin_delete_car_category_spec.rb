require 'rails_helper'

feature 'Admin delete car category' do
    scenario 'successfully' do
        user = User.create!(email: 'teste@teste.com', password: '123456')
        CarCategory.create!(name:'Sedã',daily_rate:30,car_insurance: 300, third_party_insurance: 300)

        login_as(user, scope: :user)
        visit root_path
        click_on 'Categorias de carro'
        click_on 'Sedã'
        click_on 'Deletar'

        expect(page).to have_content('Excluído com sucesso')
    end
end