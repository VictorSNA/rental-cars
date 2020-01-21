require 'rails_helper'

feature 'User schedule rental' do
  scenario 'sucessfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    client = Client.create!(name: 'Fulano da Silva', cpf: '127.587.748-60',
                            email: 'fulanodasilva@teste.com')
    car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54, car_insurance: 28,
                                       third_party_insurance: 10)
    login_as(user, user: :scope)
    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'

    fill_in 'Data de início', with: Date.current
    fill_in 'Data de fim', with: 1.day.from_now
    select "#{client.cpf} - #{client.name}", from: 'Cliente'
    select "AM", from: 'Categoria de carro'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Locação')
    expect(page).to have_content('Código')
    expect(Rental.last.code).to match(/[a-zA-Z0-9]+/)
    expect(page).to have_content('Data de início')
    expect(page).to have_content(Date.current.strftime('%d/%m/%y'))
    expect(page).to have_content('Data de fim')
    expect(page).to have_content(1.day.from_now.strftime('%d/%m/%y'))
    expect(page).to have_content('Cliente')
    expect(page).to have_content(client.name)
    expect(page).to have_content(client.cpf)
    expect(page).to have_content('Categoria de carro')
    expect(page).to have_content(car_category.name)
  end

  scenario 'and must be authenticated to register' do
    visit new_rental_path

    expect(current_path).to eq(new_user_session_path)
  end
end