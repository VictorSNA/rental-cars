require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successufully' do
    subsidiary = create(:subsidiary,
                        name: 'Saúde', cnpj: '00.000.000/0000-00',
                        address: 'Avenue Jabaquara, 1469')
    user = create(:user, subsidiary: subsidiary, status: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Saúde'

    expect(page).to have_content('Saúde')
    expect(page).to have_content('00.000.000/0000-0')
    expect(page).to have_content('Avenue Jabaquara, 1469')
  end

  scenario 'and admin must view all subsidiary' do
    subsidiary = create(:subsidiary,
                        name: 'Saúde', cnpj: '00.000.000/0000-00',
                        address: 'Avenue Jabaquara, 1469')
    user = create(:user, subsidiary: subsidiary, status: :admin)
    create(:subsidiary,
           name: 'Paraíso', cnpj: '00.000.000/0000-01',
           address: 'Avenue Paraíso, 9999')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Saúde')
    expect(page).to have_content('Paraíso')
  end

  scenario 'and admin must view all subsidiaries via route' do
    subsidiary = create(:subsidiary,
                        name: 'Saúde', cnpj: '00.000.000/0000-00',
                        address: 'Avenue Jabaquara, 1469')
    user = create(:user, subsidiary: subsidiary, status: :admin)
    another_subsidiary = create(:subsidiary,
                                name: 'Paraíso', cnpj: '00.000.000/0000-01',
                                address: 'Avenue Paraíso, 9999')

    login_as(user, scope: :user)
    visit subsidiary_path(another_subsidiary)

    expect(page).to have_content('Paraíso')
    expect(page).to have_content('00.000.000/0000-01')
    expect(page).to have_content('Avenue Paraíso, 9999')
  end
end
