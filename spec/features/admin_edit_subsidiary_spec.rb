require 'rails_helper'

feature 'Admin edit subsidiary' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary,
                        name: 'Saúde', cnpj: '00.000.000/0000-00',
                        address: 'Avenue Jabaquara')
    user = create(:user, subsidiary: subsidiary, status: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Saúde'
    click_on 'Editar'
    fill_in 'Nome', with: 'Paraíso'
    fill_in 'CNPJ', with: '00.000.000/0000-01'
    fill_in 'Endereço', with: 'Avenue Paraíso'
    click_on 'Enviar'

    expect(page).to have_content('Paraíso')
    expect(page).to have_content('00.000.000/0000-01')
    expect(page).to have_content('Avenue Paraíso')
  end

  scenario 'and must be admin to edit' do
    subsidiary = create(:subsidiary,
      name: 'Saúde', cnpj: '00.000.000/0000-00',
      address: 'Avenue Jabaquara')
    user = create(:user, subsidiary: subsidiary, status: :employee)

    login_as(user, scope: :user)
    visit edit_subsidiary_path(subsidiary)

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Você não pode fazer essa ação')
  end

  scenario 'and must be authenticate to edit' do
    visit edit_subsidiary_path(0)

    expect(current_path).to eq(new_user_session_path)
  end
end
