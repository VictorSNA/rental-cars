require 'rails_helper'

feature 'Visitor view manufacturers' do
  scenario 'successfully' do
    user = User.create!(email:'teste@teste.com', password: '123456')
    login_as(user,scope: :user)
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Volkswagen')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'

    expect(page).to have_content('Fiat')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    user = User.create!(email:'teste@teste.com', password: '123456')
    login_as(user,scope: :user)

    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Volkswagen')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and must be authenticated via button' do
    visit root_path

    expect(page).not_to have_link('Fabricantes')
  end

  scenario 'and must be authenticated via route' do
    visit manufacturers_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated to view details' do
    visit manufacturer_path(00000)

    expect(current_path).to eq(new_user_session_path)
  end

end