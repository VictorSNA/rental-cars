require 'rails_helper'

feature 'Admin view car Categories' do
    scenario 'successfully' do
        CarCategory.create!(name: 'SUV compacto', daily_rate: 45.5, car_insurance: 300.05, third_party_insurance: 300.00)

        visit root_path
        click_on 'Categorias de carro'
        click_on 'SUV compacto'

        expect(page).to have_content('SUV compacto')
        expect(page).to have_content('45.5')
        expect(page).to have_content('300.05')
        expect(page).to have_content('300.0')
    end

end