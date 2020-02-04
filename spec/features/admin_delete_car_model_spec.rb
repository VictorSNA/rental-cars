require 'rails_helper'

feature 'Admin delete car model' do
  scenario 'successfully' do
    user = create(:user)
    create(:car_model, name: 'Onix hatch')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Onix hatch'
    click_on 'Deletar'

    expect(page).to have_content('Modelo de carro excluído com sucesso')
  end
end
