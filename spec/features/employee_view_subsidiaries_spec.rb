require 'rails_helper'

feature 'Employee view subsidiaries' do
  scenario 'successufully' do
    subsidiary = create(:subsidiary,
                        name: 'Saúde', cnpj: '00.000.000/0000-00',
                        address: 'Avenue Jabaquara, 1469')
    user = create(:user, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Saúde'

    expect(page).to have_content('Saúde')
    expect(page).to have_content('00.000.000/0000-0')
    expect(page).to have_content('Avenue Jabaquara, 1469')
  end

  scenario 'and employee must see one subsidiary' do
    subsidiary = create(:subsidiary,
                        name: 'Saúde', cnpj: '00.000.000/0000-00',
                        address: 'Avenue Jabaquara, 1469')
    user = create(:user, subsidiary: subsidiary)
    create(:subsidiary,
           name: 'Paraíso', cnpj: '00.000.000/0000-01',
           address: 'Avenue Paraíso, 9999')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Saúde')
    expect(page).not_to have_content('Paraíso')
  end

  scenario 'and employee must see one subsidiary via route' do
    subsidiary = create(:subsidiary,
                        name: 'Saúde', cnpj: '00.000.000/0000-00',
                        address: 'Avenue Jabaquara, 1469')
    user = create(:user, subsidiary: subsidiary)
    another_subsidiary = create(:subsidiary,
                                name: 'Paraíso', cnpj: '00.000.000/0000-01',
                                address: 'Avenue Paraíso, 9999')

    login_as(user, scope: :user)
    visit subsidiary_path(another_subsidiary)

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Você não pode fazer essa ação')
  end

  scenario ' and return to home page' do
    subsidiary = create(:subsidiary)
    user = create(:user, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit subsidiary_path(subsidiary)
    click_on 'Home'

    expect(current_path).to eq(root_path)
  end

  scenario 'and must be authenticated via button' do
    visit root_path

    expect(page).not_to have_link('Filiais')
  end

  scenario 'and must be authenticated via route' do
    visit subsidiaries_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated to view details' do
    visit subsidiary_path(0)

    expect(current_path).to eq(new_user_session_path)
  end
end
