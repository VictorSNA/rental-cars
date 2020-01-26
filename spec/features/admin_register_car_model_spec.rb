require 'rails_helper'

feature 'Admin register Car Model' do
    scenario 'successfully' do
        user = User.create!(email: 'teste@teste.com', password: '123456')
        Manufacturer.create!(name: 'Chevrolet')
        CarCategory.create!(name:'Sedã compacto', daily_rate: 30, car_insurance:300,
                            third_party_insurance: 300)
        login_as(user, scope: :user)
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

        expect(page).to have_css('h1', text:'MODELO:')
        expect(page).to have_css('h2', text:'Onix Hatch')
        expect(page).to have_css('h3', text:'Detalhes:')
        expect(page).to have_css('p', text:'Ano: 2019')
        expect(page).to have_css('p', text:'Fabricante: Chevrolet')
        expect(page).to have_css('p', text:'Motorização: 1.4')
        expect(page).to have_css('p', text: 'Categoria: Sedã compacto')
        expect(page).to have_css('p', text:'Tipo de combustível: Flex')
    end

    scenario 'and must be authenticated to register' do
      visit new_car_model_path

      expect(current_path).to eq(new_user_session_path)
    end

    scenario 'and fields must be present' do
      user = User.create!(email: 'teste@teste.com', password: '123456')

      login_as(user, scope: :user)
      visit new_car_model_path

      click_on 'Enviar'

      expect(page).to have_content('Name não pode ficar vazio')
      expect(page).to have_content('Year não pode ficar vazio')
      expect(page).to have_content('Manufacturer não pode ficar vazio')
      expect(page).to have_content('Motorization não pode ficar vazio')
      expect(page).to have_content('Car category não pode ficar vazio')
      expect(page).to have_content('Fuel type não pode ficar vazio')
    end
    scenario 'and name must be less or equal to 64' do
      user = User.create!(email: 'teste@teste.com', password: '123456')
      Manufacturer.create!(name: 'Chevrolet')
      CarCategory.create!(name:'Sedã compacto', daily_rate: 30, car_insurance:300,
                          third_party_insurance: 300)
      login_as(user, scope: :user)
      visit new_car_model_path

      fill_in 'Nome', with: 'a' * 65

      click_on 'Enviar'

      expect(page).to have_content('Name muito grande')
    end
    scenario 'and year must be less or equal to 4' do
      user = User.create!(email: 'teste@teste.com', password: '123456')
      
      login_as(user, scope: :user)
      visit new_car_model_path

      fill_in 'Ano', with: '1' * 5

      click_on 'Enviar'

      expect(page).to have_content('Year muito grande')
    end
    scenario 'and motorization must be less or equal to 3' do
      user = User.create!(email: 'teste@teste.com', password: '123456')

      login_as(user, scope: :user)
      visit new_car_model_path

      fill_in 'Motorização', with: '1' * 4

      click_on 'Enviar'

      expect(page).to have_content('Motorization deve ser até 3 caracteres')
    end
    scenario 'and fuel type must be less or equal to 64' do
      user = User.create!(email: 'teste@teste.com', password: '123456')

      login_as(user, scope: :user)
      visit new_car_model_path

      fill_in 'Tipo de combustível', with: '1' * 65

      click_on 'Enviar'

      expect(page).to have_content('Fuel type deve ser até 64 caracteres')
    end
end
