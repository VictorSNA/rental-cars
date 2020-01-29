require 'rails_helper'

feature 'Admin edit Car Category' do
    scenario 'successfully' do
        user = User.create!(email: 'teste@teste.com', password: '123456')
        CarCategory.create!(name:'Sedã', daily_rate: 30, car_insurance: 300, third_party_insurance: 300)
        
        login_as(user, scope: :user)
        visit root_path
        
        click_on 'Categorias de carro'
        click_on 'Sedã'
        click_on 'Editar'

        fill_in 'Nome', with: 'SUV compacto'
        click_on 'Enviar'

        expect(page).to have_content('Editado com sucesso')
        expect(page).to have_content('SUV compacto')
    end

    scenario 'and must be authenticated to edit' do
        visit edit_car_category_path(00000)

        expect(current_path).to eq(new_user_session_path)
    end

    scenario 'and must be a valid car category to edit' do
        user = User.create!(email: 'teste@teste.com', password: '123456')

        login_as(user, scope: :user)
        visit edit_car_category_path(00000)

        expect(current_path).to eq(root_path)
        expect(page).to have_content('Você não pode fazer essa ação')
    end
end