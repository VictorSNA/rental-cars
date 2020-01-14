require 'rails_helper'

feature 'Admin delete manufacturer' do
    scenario 'successfully' do
        user = User.create!(email: 'teste@teste.com', password: '123456')
        Manufacturer.create!(name: 'Volkswagen')

        login_as(user, scope: :user)
        visit root_path
        click_on 'Fabricantes'
        click_on 'Volkswagen'
        click_on 'Deletar'

        expect(page).to have_content('Fabricante excluído com sucesso')
    end

end