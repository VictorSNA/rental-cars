require 'rails_helper'

feature 'User schedule rental' do
  scenario 'sucessfully' do
    user = create(:user)
    client = create(:client, name: 'Fulano da Silva', cpf: '127.587.748-60')
    car_category = create(:car_category, name: 'AM')
    car_model = create(:car_model, car_category: car_category)
    create(:car, car_model: car_model)
    create(:accessory, name: 'Bebê conforto')

    login_as(user, user: :scope)
    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'
    fill_in 'Data de início', with: Date.current
    fill_in 'Data de fim', with: 1.day.from_now
    select "#{client.cpf} - #{client.name}", from: 'Cliente'
    check 'Bebê conforto'
    select 'AM', from: 'Categoria de carro'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Locação')
    expect(Rental.last.code).to match(/[a-zA-Z0-9]+/)
    expect(page).to have_content(I18n.l(Date.current, format: :resume))
    expect(page).to have_content(I18n.l(1.day.from_now, format: :resume))
    expect(page).to have_content(client.name)
    expect(page).to have_content(client.cpf)
    expect(page).to have_content(car_category.name)
    expect(page).to have_content('Bebê conforto')
  end

  scenario 'and must have existing cars avaliables to schedule' do
    user = create(:user)
    create(:car_category, name: 'AM')

    login_as(user, user: :scope)
    visit new_rental_path
    select 'AM', from: 'Categoria de carro'
    click_on 'Enviar'

    expect(page).to have_content('Não existem carros disponíveis '\
                                 'desta categoria')
  end

  scenario 'and must be authenticated to register' do
    visit new_rental_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and start and end date must be filled' do
    user = create(:user)

    login_as(user, user: :scope)
    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'
    click_on 'Enviar'

    expect(page).to have_content('Data de início não pode ficar em branco')
    expect(page).to have_content('Data de fim não pode ficar em branco')
  end

  scenario 'and start cannot be in the past' do
    user = create(:user)

    login_as(user, user: :scope)
    visit new_rental_path
    fill_in 'Data de início', with: 1.day.ago
    click_on 'Enviar'

    expect(page).to have_content('Data de início não pode estar no passado')
  end

  scenario 'and start cannot be in greater than end date' do
    create(:car_category)
    user = create(:user)

    login_as(user, user: :scope)
    visit new_rental_path
    fill_in 'Data de início', with: 1.day.from_now
    fill_in 'Data de fim', with: Date.current
    click_on 'Enviar'

    expect(page).to have_content('Data de início não pode ser maior '\
                                 'que a data final')
  end
end
