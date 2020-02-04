require 'rails_helper'

feature 'Admin view car categories' do
  scenario 'successfully' do
    user = create(:user)
    create(:car_category,
           name: 'SUV compacto',
           daily_rate: 45.5,
           car_insurance: 300.05,
           third_party_insurance: 300.00)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    click_on 'SUV compacto'

    expect(page).to have_content('SUV compacto')
    expect(page).to have_content('45.5')
    expect(page).to have_content('300.05')
    expect(page).to have_content('300.0')
  end

  scenario 'and must be authenticated via button' do
    visit root_path

    expect(page).not_to have_content('Categorias de carro')
  end

  scenario 'and must be authenticated via route' do
    visit car_categories_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated to view details' do
    visit car_category_path(0)

    expect(current_path).to eq(new_user_session_path)
  end
end
