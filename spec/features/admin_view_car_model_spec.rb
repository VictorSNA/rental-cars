require 'rails_helper'

feature 'Admin view Car Model' do
    scenario 'successfully' do
        user = User.create!(email: 'teste@teste.com', password: '123456')
        manufacturer = Manufacturer.create!(name: 'Chevrolet')
        car_category = CarCategory.create!(name: 'Sedã compacto', daily_rate: 30,
                                        car_insurance: 300, third_party_insurance: 300)
        car_model = CarModel.create!(name: 'Onix hatch', year: '2019', manufacturer: manufacturer,
                            motorization: '1.4', car_category: car_category, fuel_type: 'Flex')
        
        login_as(user, scope: :user)
        visit root_path
        click_on 'Modelos de carro'
        click_on car_model.name

        expect(page).to have_css('h1', text:'MODELO:')
        expect(page).to have_css('h2', text:car_model.name)
        expect(page).to have_css('h3', text:'Detalhes:')
        expect(page).to have_css('p', text:"Ano: #{car_model.year}")
        expect(page).to have_css('p', text:"Fabricante: #{car_model.manufacturer.name}")
        expect(page).to have_css('p', text:"Motorização: #{car_model.motorization}")
        expect(page).to have_css('p', text: "Categoria: #{car_model.car_category.name}")
        expect(page).to have_css('p', text:"Tipo de combustível: #{car_model.fuel_type}")
    end
    scenario 'and must be authenticated via button' do
        visit root_path

        expect(page).not_to have_content('Modelos de carro')
    end

    scenario 'and must be authenticated via route' do
        visit car_models_path

        expect(current_path).to eq(new_user_session_path)
    end

    scenario 'and must be authenticated to view details' do
        visit car_model_path(00000)

        expect(current_path).to eq(new_user_session_path)
    end

end