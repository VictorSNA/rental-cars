require 'rails_helper'

feature 'User cancel rental' do
  scenario 'successfully' do
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
                    start_date: Date.current, status: :active,
                    subsidiary: subsidiary)
    create(:car_rental, car: car, rental: rental)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'
    click_on 'Cancelar'
    fill_in 'Descrição', with: 'Não estarei mais em SP na data escolhida'
    click_on 'Enviar'

    expect(page).to have_content('Locação cancelada com sucesso')
  end

  scenario 'must be within 24 hours' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    car_category = create(:car_category)
    car_model = create(:car_model,
                       car_category: car_category)
    car = create(:car,
                 car_model: car_model, status: 5)
    rental = build(:rental,
                   code: 'VKN0001', car_category: car_category, user: user,
                   start_date: 2.days.ago, status: :active,
                   subsidiary: subsidiary)
    rental.save(validate: false)
    create(:car_rental, car: car, rental: rental)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'
    click_on 'Cancelar'
    fill_in 'Descrição', with: 'Não estarei mais em SP na data escolhida'
    click_on 'Enviar'

    expect(page).to have_content('Data de início já ultrapassou 24 horas')
  end

  scenario 'but user must be from subsidiary' do
    subsidiary = create(:subsidiary, name: 'Saúde', cnpj: '47.293.874/0001-48',
                                     address: 'Avenue Jabaquara, 3000')
    user = create(:user)
    another_user = create(:user, subsidiary: subsidiary)
    car_category = create(:car_category)
    car_model = create(:car_model,
                       car_category: car_category)
    car = create(:car,
                 car_model: car_model, status: 5)
    rental = build(:rental,
                   code: 'VKN0001', car_category: car_category, user: user,
                   start_date: 2.days.ago, status: :active)
    rental.save(validate: false)
    create(:car_rental, car: car, rental: rental)

    login_as(another_user, scope: :user)
    visit cancel_rental_path(rental)

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Você não pode fazer essa ação')
  end
end
