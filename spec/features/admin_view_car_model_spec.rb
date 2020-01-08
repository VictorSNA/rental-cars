require 'rails_helper'

feature 'Admin view Car Model' do
    scenario 'successfully' do
        manufacturer = Manufacturer.create!(name: 'Chevrolet')
        car_category = CarCategory.create!(name: 'Sedã compacto', daily_rate: 30,
                                        car_insurance: 300, third_party_insurance: 300)
        car_model = CarModel.create!(name: 'Onix hatch', year: '2019', manufacturer: manufacturer,
                            motorization: '1.4', car_category: car_category, fuel_type: 'Flex')
        
        visit root_path
        click_on 'Modelos de carro'
        click_on car_model.name

        expect(page).to have_css('h1', text:car_model.name)
        expect(page).to have_css('h3', text:'Detalhes')
        expect(page).to have_css('p', text:car_model.year)
        expect(page).to have_css('p', text:car_model.manufacturer.name)
        expect(page).to have_css('p', text:car_model.motorization)
        expect(page).to have_css('p', text:car_model.car_category.name)
        expect(page).to have_css('p', text:car_model.fuel_type)
    end

end