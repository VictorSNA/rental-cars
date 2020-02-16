require 'rails_helper'

feature 'Admin delete subsidiary' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary, name: 'Jabaquara')
    user = create(:user, subsidiary: subsidiary, status: 5)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Jabaquara'

    click_on 'Deletar'

    expect(page).to have_content('Filial excluída com sucesso')
  end
end
