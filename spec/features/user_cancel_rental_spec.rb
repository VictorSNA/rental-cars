require 'rails_helper'

feature 'User cancel rental' do
  scenario 'successfully' do
    user = create(:user)
    car_category = create(:car_category)
    car_model = create(:car_model, car_category: car_category)
    car = create(:car, car_model: car_model)
    rental = create(:rental, code: 'VKN0001', car_category: car_category,
                    user: user, start_date: Date.current)
    create(:car_rental, car: car, rental: rental)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'
    click_on 'VKN0001'
    click_on 'Cancelar'

    expect(page).to have_content('Locação cancelada com sucesso')
  end
end