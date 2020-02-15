require 'rails_helper'

describe Rental do
  describe '#start_date_cannot_be_in_the_past' do
    it 'should prevent start date in the past' do
      rental = build(:rental, start_date: 1.day.ago)
      rental.valid?

      expect(rental.errors.full_messages).to include('Data de início não '\
                                                     'pode estar no passado')
    end
  end

  describe '#start_date_cannot_be_greater_than_end_date' do
    it 'should prevent start date to be greater than end date' do
      rental = build(:rental,
                     start_date: 1.day.from_now, end_date: Date.current)
      rental.valid?

      expect(rental.errors.full_messages).to include('Data de início não '\
                                                     'pode ser maior que '\
                                                     'a data final')
    end
  end

  describe '#fields_cannot_be_blank' do
    it 'should prevent start date to be blank' do
      rental = build(:rental, start_date: nil)
      rental.valid?

      expect(rental.errors.full_messages).to include('Data de início não '\
                                                     'pode ficar em branco')
    end

    it 'should prevent end date to be blank' do
      rental = build(:rental, end_date: nil)
      rental.valid?

      expect(rental.errors.full_messages).to include('Data de fim não '\
                                                     'pode ficar em branco')
    end

    it 'should prevent start date and end date to be blank' do
      rental = build(:rental, start_date: nil, end_date: nil)
      rental.valid?

      expect(rental.errors.full_messages).to include('Data de início não '\
                                                     'pode ficar em branco')
      expect(rental.errors.full_messages).to include('Data de fim não '\
                                                     'pode ficar em branco')
    end
  end
end
