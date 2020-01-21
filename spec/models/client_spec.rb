require 'rails_helper'

describe Client do
  describe '#identification' do
    it 'should create a basic identification' do
      client = Client.create!(name: 'Fulano da Silva', cpf: '127.587.748-60',
                            email: 'fulanodasilva@teste.com')
      result = client.identification
      
      expect(result).to eq '127.587.748-60 - Fulano da Silva'
    end
  end
end
