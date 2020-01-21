require 'rails_helper'

describe CarRental do
  describe '#fields_must_be_present' do
    it 'should prevent daily_rate to be blank' do
      car_rental = CarRental.new(daily_rate: nil)
      car_rental.valid?
      expect(car_rental.errors.full_messages).to include('Daily rate não pode ficar vazio')
    end
    it 'should prevent start_mileage to be blank' do
      car_rental = CarRental.new(start_mileage: nil)
      car_rental.valid?
      expect(car_rental.errors.full_messages).to include('Start mileage não pode ficar vazio')
    end
    it 'should prevent daily_rate and start mileage to be blank' do
      car_rental = CarRental.new(daily_rate: nil, start_mileage: nil)
      car_rental.valid?
      expect(car_rental.errors.full_messages).to include('Daily rate não pode ficar vazio')
      expect(car_rental.errors.full_messages).to include('Start mileage não pode ficar vazio')
    end
  end
end
