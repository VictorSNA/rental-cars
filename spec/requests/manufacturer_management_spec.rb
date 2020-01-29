require 'rails_helper'

describe 'Car model management' do
  context 'delete' do

    it 'successfully' do
      manufacturer = Manufacturer.create!(name: 'Fiat')
  
      delete manufacturer_path(manufacturer)
      
      expect(flash[:notice]).to include 'Fabricante excluído com sucesso'
    end
    it 'should delete a car model that exists' do
      delete manufacturer_path(0)

      expect(flash[:alert]).to include 'Você não pode fazer essa ação'
    end
  end
end