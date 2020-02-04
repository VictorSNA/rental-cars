require 'rails_helper'

feature 'Admin delete manufacturer' do
  scenario 'successfully' do
    user = create(:user)
    create(:manufacturer, name: 'Volkswagen')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Volkswagen'
    click_on 'Deletar'

    expect(page).to have_content('Fabricante excluído com sucesso')
  end
end
