require 'rails_helper'

feature 'Admin register Car Category' do
  scenario 'sucessfully' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    click_on 'Cadastrar categoria de carro'
    fill_in 'Nome', with: 'AM'
    fill_in 'Diária', with: 30
    fill_in 'Seguro do automóvel', with: 300
    fill_in 'Seguro contra terceiros', with: 250

    click_on 'Enviar'

    expect(page).to have_content('AM')
    expect(page).to have_content(30)
    expect(page).to have_content(300)
    expect(page).to have_content(250)
  end

  scenario 'and fields must be filled' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    click_on 'Cadastrar categoria de carro'
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Diária não pode ficar em branco')
    expect(page).to have_content('Seguro do automóvel não pode ficar em branco')
    expect(page).to have_content('Seguro contra terceiros não pode ficar '\
                                 'em branco')
  end

  scenario 'and name must be unique' do
    user = create(:user)
    create(:car_category,
           name: 'AM', daily_rate: 30, car_insurance: 300,
           third_party_insurance: 300)

    login_as(user, scope: :user)
    visit new_car_category_path
    fill_in 'Nome', with: 'AM'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and name must be less or equal to 32 characteres' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_car_category_path
    fill_in 'Nome', with: 'a' * 33
    click_on 'Enviar'

    expect(page).to have_content('Nome é muito longo (máximo: 32 caracteres)')
  end

  scenario 'and name must be unique and case insensitive' do
    user = create(:user)
    create(:car_category, name: 'AM')

    login_as(user, scope: :user)
    visit new_car_category_path
    fill_in 'Nome', with: 'am'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and daily rate, car insurance, third party insurance must be '\
           'greater than 0' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_car_category_path
    fill_in 'Diária', with: -1
    fill_in 'Seguro do automóvel', with: -1
    fill_in 'Seguro contra terceiros', with: -1
    click_on 'Enviar'

    expect(page).to have_content('Diária deve ser maior que 0')
    expect(page).to have_content('Seguro do automóvel deve ser maior que 0')
    expect(page).to have_content('Seguro contra terceiros deve ser maior que 0')
  end

  scenario 'and daily rate must be lesser or equal than 1 million' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_car_category_path
    fill_in 'Diária', with: 1_000_001
    click_on 'Enviar'

    expect(page).to have_content('Diária deve ser menor ou igual a 1000000')
  end

  scenario 'and car insurance must be lesser or equal than 1 million' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_car_category_path
    fill_in 'Seguro do automóvel', with: 1_000_001
    click_on 'Enviar'

    expect(page).to have_content('Seguro do automóvel deve ser '\
                                 'menor ou igual a 1000000')
  end

  scenario 'and third party insurance must be lesser or equal than 1 million' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_car_category_path
    fill_in 'Seguro contra terceiros', with: 1_000_001
    click_on 'Enviar'

    expect(page).to have_content('Seguro contra terceiros deve ser '\
                                 'menor ou igual a 100000')
  end

  scenario 'and must be authenticated to register' do
    visit new_car_category_path

    expect(current_path).to eq(new_user_session_path)
  end
end
