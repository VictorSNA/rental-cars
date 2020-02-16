require 'rails_helper'

feature 'User begin rental' do
  scenario 'and view all avaliable cars before' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    manufacturer = create(:manufacturer, name: 'Renault')
    car_category = create(:car_category, name: 'AM')
    another_car_category = create(:car_category, name: 'BM')
    car_model = create(:car_model,
                       name: 'Kwid', manufacturer: manufacturer,
                       car_category: car_category)
    other_car_model = create(:car_model,
                             name: 'Sandero', manufacturer: manufacturer,
                             car_category: another_car_category)
    create(:car,
           license_plate: 'ABC1234', color: 'Branco', car_model: car_model)
    create(:car,
           license_plate: 'DEF5678', color: 'Azul', car_model: other_car_model)
    create(:rental, code: 'VKN0001', car_category: car_category, user: user,
                    subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'
    click_on 'VKN0001'

    expect(page).to have_content('Selecionar o carro')
    expect(page).to have_content('Renault Kwid - ABC1234 - Branco')
    expect(page).not_to have_content('Renault Sandero - DEF5678 - Azul')
  end

  scenario 'successfully' do
    subsidiary = create(:subsidiary, name: 'Paraíso')
    user = create(:user, subsidiary: subsidiary)
    manufacturer = create(:manufacturer, name: 'Renault')
    car_category = create(:car_category, name: 'AM')
    car_model = create(:car_model,
                       name: 'Kwid', manufacturer: manufacturer,
                       car_category: car_category)
    car = create(:car,
                 license_plate: 'ABC1234', color: 'Branco',
                 car_model: car_model, status: 0)
    create(:car, car_model: car_model)
    create(:rental, code: 'VKN0001', car_category: car_category, user: user,
                    subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'
    click_on 'VKN0001'
    within "#div-#{car.id}" do
      click_on 'Iniciar'
    end

    expect(page).to have_content('Locação - VKN0001')
    expect(page).to have_content('Renault Kwid - ABC1234 - Branco')
    expect(page).to have_content('Fulano da Silva')
    expect(page).to have_content(user.email)
    expect(page).to have_content('R$ 46,54')
    expect(page).to have_content('R$ 28')
    expect(page).to have_content('R$ 10')
    expect(page).to have_content('R$ 84,54')
    expect(page).to have_content('Paraíso')
  end

  scenario 'and rental status must change' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    manufacturer = create(:manufacturer, name: 'Renault')
    car_category = create(:car_category, name: 'AM')
    car_model = create(:car_model,
                       name: 'Kwid', manufacturer: manufacturer,
                       car_category: car_category)
    car = create(:car,
                 license_plate: 'ABC1234', color: 'Branco',
                 car_model: car_model, status: 0)
    create(:car, car_model: car_model)
    rental = create(:rental, code: 'VKN0001', car_category: car_category,
                             user: user, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'
    click_on 'VKN0001'
    within "#div-#{car.id}" do
      click_on 'Iniciar'
    end

    expect(rental.reload.status).to eq 'active'
    expect(page).to have_content('Locação - VKN0001')
    expect(page).to have_content('Renault Kwid - ABC1234 - Branco')
  end

  scenario 'and unavaliable cars must be blocked via button' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    manufacturer = create(:manufacturer, name: 'Renault')
    car_category = create(:car_category, name: 'AM')
    another_car_category = create(:car_category, name: 'BM')
    car_model = create(:car_model,
                       name: 'Kwid', manufacturer: manufacturer,
                       car_category: car_category)
    other_car_model = create(:car_model,
                             name: 'Kwid', manufacturer: manufacturer,
                             car_category: another_car_category)
    create(:car,
           license_plate: 'ABC1234', color: 'Branco', car_model: car_model,
           status: 0)
    create(:car,
           license_plate: 'DEF5678', color: 'Azul', car_model: other_car_model,
           status: 5)
    create(:rental, code: 'VKN0001', car_category: car_category, user: user,
                    subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'
    click_on 'VKN0001'

    expect(page).to have_content('ABC1234')
    expect(page).not_to have_content('DEF5678')
  end

  scenario 'and scheduled rentals must not view avaliable cars' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    manufacturer = create(:manufacturer, name: 'Renault')
    car_category = create(:car_category, name: 'AM')
    car_model = create(:car_model,
                       name: 'Kwid', manufacturer: manufacturer,
                       car_category: car_category)
    car = create(:car,
                 license_plate: 'ABC1234', color: 'Branco',
                 car_model: car_model, status: 0)
    create(:car, license_plate: 'DEF123', color: 'Cinza',
                 car_model: car_model, status: 0)
    rental = create(:rental, code: 'VKN0001', car_category: car_category,
                             user: user, status: :active,
                             subsidiary: subsidiary)
    create(:car_rental, rental: rental, car: car)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'

    expect(page).not_to have_link('VKN0001')
  end
end
