require 'rails_helper'

feature 'Admin view reports' do
  scenario 'and filter by car category and period' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    car_category = create(:car_category)
    car_model = create(:car_model,
                       car_category: car_category)
    car = create(:car,
                 car_model: car_model, status: 5)
    create(:car, car_model: car_model)
    rental = create(:rental,
                    code: 'VKN0001', car_category: car_category, user: user,
                    start_date: Date.current, end_date: 1.day.from_now,
                    status: :active, subsidiary: subsidiary)
    another_rental = create(:rental,
                    code: 'VKN0002', car_category: car_category, user: user,
                    start_date: 5.days.from_now, end_date: 7.days.from_now,
                    status: :active, subsidiary: subsidiary)
    create(:car_rental, car: car, rental: rental)
    create(:car_rental, car: car, rental: another_rental)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Relatórios'
    select 'Todas filiais', from: 'Escolher filial'
    select 'Todas categorias', from: 'Escolher categoria de carro'
    select 'Todos modelos', from: 'Escolher modelo de carro'
    fill_in 'Data de início', with: 10.days.ago
    fill_in 'Data de fim', with: 10.days.from_now
    click_on 'Gerar relatório'

    expect(page).to have_content('VKN0001')
    expect(page).to have_content(Date.current)
    expect(page).to have_content(1.day.from_now)
    expect(page).to have_content('VKN0002')
    expect(page).to have_content(5.days.from_now)
    expect(page).to have_content(7.days.from_now)
  end
end