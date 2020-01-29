require 'rails_helper'

describe 'Car model management' do
  context 'delete' do

    it 'successfully' do
      car_category = CarCategory.create!(name: 'A', daily_rate: 36.5,
                                         car_insurance: 32.90,
                                         third_party_insurance: 30.90)
  
      delete car_category_path(car_category)
      
      expect(flash[:notice]).to include 'Excluído com sucesso'
    end
    it 'should delete a car model that exists' do
      delete car_category_path(00000)

      expect(flash[:alert]).to include 'Você não pode fazer essa ação'
    end
  end
end