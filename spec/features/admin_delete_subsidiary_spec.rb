require 'rails_helper'

feature 'Admin delete subsidiary' do
  scenario 'successfully' do
    user = create(:user)
    create(:subsidiary, name: 'Jabaquara')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Jabaquara'

    click_on 'Deletar'

    expect(page).to have_content('Filial excluída com sucesso')
  end
end
