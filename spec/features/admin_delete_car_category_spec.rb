require 'rails_helper'

feature 'Admin delete car category' do
  scenario 'successfully' do
    user = create(:user)
    create(:car_category, name: 'AM')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de carro'
    click_on 'AM'
    click_on 'Deletar'

    expect(page).to have_content('Excluído com sucesso')
  end
end
