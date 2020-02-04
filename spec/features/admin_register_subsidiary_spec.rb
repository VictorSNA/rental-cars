require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar Filial'

    fill_in 'Nome', with: 'Paraíso'
    fill_in 'CNPJ', with: '00.000.000/0000-01'
    fill_in 'Endereço', with: 'Avenue Paraíso'

    click_on 'Enviar'

    expect(page).to have_content('Filial registrada com sucesso')
    expect(page).to have_content('Paraíso')
    expect(page).to have_content('00.000.000/0000-01')
    expect(page).to have_content('Avenue Paraíso')
  end

  scenario 'and fields must be filled' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar Filial'
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
  end

  scenario 'and must be unique' do
    user = create(:user)
    create(:subsidiary)

    login_as(user, scope: :user)
    visit new_subsidiary_path

    fill_in 'Nome', with: 'Paraíso'
    fill_in 'CNPJ', with: '20.091.076/0001-87'
    fill_in 'Endereço', with: 'Avenue Paraíso'

    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
    expect(page).to have_content('CNPJ já está em uso')
  end

  scenario 'and must be unique and case sensitive' do
    user = create(:user)
    create(:subsidiary)

    login_as(user, scope: :user)
    visit new_subsidiary_path

    fill_in 'Nome', with: 'paraíso'
    fill_in 'CNPJ', with: '00.000.000/0000-21'
    fill_in 'Endereço', with: 'Avenue Paraíso. 234'

    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and name must be lesser than 64 characteres' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_subsidiary_path

    fill_in 'Nome', with: 'a' * 65
    fill_in 'CNPJ', with: '00.000.000/0000-01'
    fill_in 'Endereço', with: 'Avenue Paraíso'

    click_on 'Enviar'

    expect(page).to have_content('Nome é muito longo (máximo: 64 caracteres)')
  end

  scenario 'and address must be lesser than 128 characteres' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_subsidiary_path

    fill_in 'Nome', with: 'Paraíso'
    fill_in 'CNPJ', with: '00.000.000/0000-01'
    fill_in 'Endereço', with: 'a' * 129

    click_on 'Enviar'

    expect(page).to have_content('Endereço é muito longo '\
                                 '(máximo: 128 caracteres)')
  end

  scenario 'field CNPJ must be valid' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_subsidiary_path

    fill_in 'Nome', with: 'Paraíso'
    fill_in 'CNPJ', with: '00000000000'

    click_on 'Enviar'

    expect(page).to have_content('CNPJ não possui o tamanho esperado '\
                                 '(18 caracteres)')
  end

  scenario 'and must be authenticated to register' do
    visit new_subsidiary_path

    expect(current_path).to eq(new_user_session_path)
  end
end
