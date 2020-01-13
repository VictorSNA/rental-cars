require 'rails_helper'

feature 'Admin delete car model' do
    scenario 'successfully' do
        manufacturer = Manufacturer.create!(name: 'Chevrolet')
        car_category = CarCategory.create!(name: 'Sedã compacto', daily_rate: 30,
                                        car_insurance: 300, third_party_insurance: 300)
        car_model = CarModel.create!(name: 'Onix hatch', year: '2019', manufacturer: manufacturer,
                            motorization: '1.4', car_category: car_category, fuel_type: 'Flex')

        visit root_path
        click_on 'Modelos de carro'
        click_on 'Onix hatch'
        click_on 'Deletar'

        expect(page).to have_content('Modelo de carro excluído com sucesso')

    end
end