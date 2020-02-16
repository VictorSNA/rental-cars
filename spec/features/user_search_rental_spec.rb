require 'rails_helper'

feature 'User search rental' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    car_category = create(:car_category, name: 'AM')
    client = create(:client, name: 'Fulano da Silva')
    car_model = create(:car_model, car_category: car_category)
    create(:car, car_model: car_model)
    create(:rental,
           client: client, user: user, code: 'VKN0001',
           car_category: car_category, start_date: Date.current,
           end_date: 1.day.from_now, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'

    expect(page).to have_css('h1', text: 'Locações')
    expect(page).to have_content('Código')
    expect(page).to have_content('VKN0001')
    expect(page).to have_content('Data de início')
    expect(page).to have_content(I18n.l(Date.current, format: :resume))
    expect(page).to have_content('Data de fim')
    expect(page).to have_content(I18n.l(1.day.from_now, format: :resume))
    expect(page).to have_content('Cliente')
    expect(page).to have_content(client.name)
    expect(page).to have_content('Categoria de carro')
    expect(page).to have_content(car_category.name)
  end

  scenario 'with a partial code' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)
    car_category = create(:car_category, name: 'AM')
    client = create(:client, name: 'Fulano da Silva')
    car_model = create(:car_model, car_category: car_category)
    create(:car, car_model: car_model)
    create(:car, car_model: car_model)
    create(:rental,
           client: client, user: user, code: 'VKN0001',
           car_category: car_category, start_date: Date.current,
           end_date: 1.day.from_now, subsidiary: subsidiary)
    create(:rental,
           client: client, user: user, code: 'VKN0002',
           car_category: car_category, start_date: Date.current,
           end_date: 1.day.from_now, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit rentals_path
    fill_in 'Pesquisar', with: 'VKN'
    click_on 'Buscar'

    expect(page).to have_content('VKN0001')
    expect(page).to have_content('VKN0002')
  end

  scenario 'and must be from subsidiary to find or admin' do
    subsidiary = create(:subsidiary, name: 'Saúde', cnpj: '47.293.874/0001-48',
                                     address: 'Avenue Jabaquara, 1300')
    user = create(:user, subsidiary: subsidiary)
    another_user = create(:user)
    car_category = create(:car_category, name: 'AM')
    client = create(:client, name: 'Fulano da Silva')
    car_model = create(:car_model, car_category: car_category)
    create(:car, car_model: car_model)
    create(:rental,
           client: client, user: user, code: 'VKN0001',
           car_category: car_category, start_date: Date.current,
           end_date: 1.day.from_now, subsidiary: subsidiary)

    login_as(another_user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Pesquisar', with: 'VKN0001'
    click_on 'Buscar'

    expect(page).to have_content('Nenhuma locação encontrada')
  end

  scenario 'and must be authenticated via button' do
    visit root_path

    expect(page).not_to have_content('Locações')
  end

  scenario 'and must be authenticated via route' do
    visit rentals_path

    expect(current_path).to eq(new_user_session_path)
  end
end
