require 'rails_helper'

feature 'Admin edit Car Category' do
  scenario 'successfully' do
    user = create(:user)
    create(:car_category, name: 'AM')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    click_on 'AM'
    click_on 'Editar'
    fill_in 'Nome', with: 'SUV compacto'
    click_on 'Enviar'

    expect(page).to have_content('Editado com sucesso')
    expect(page).to have_content('SUV compacto')
  end

  scenario 'and must be authenticated to edit' do
    visit edit_car_category_path(0)

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be a valid car category to edit' do
    user = create(:user)

    login_as(user, scope: :user)
    visit edit_car_category_path(0)

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Você não pode fazer essa ação')
  end
end
