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
    it 'should prevent car_insurance to be blank' do
      car_rental = CarRental.new(car_insurance: nil)
      car_rental.valid?
      expect(car_rental.errors.full_messages).to include('Car insurance não pode ficar vazio')
    end
    it 'should prevent third_party_insurance to be blank' do
      car_rental = CarRental.new(third_party_insurance: nil)
      car_rental.valid?
      expect(car_rental.errors.full_messages).to include('Third party insurance não pode ficar vazio')
    end
    it 'should prevent all fields to be blank' do
      car_rental = CarRental.new()
      car_rental.valid?
      expect(car_rental.errors.full_messages).to include('Start mileage não pode ficar vazio')
      expect(car_rental.errors.full_messages).to include('Third party insurance não pode ficar vazio')
      expect(car_rental.errors.full_messages).to include('Car insurance não pode ficar vazio')
      expect(car_rental.errors.full_messages).to include('Daily rate não pode ficar vazio')
    end
  end
  describe '#daily_rate_total' do
    it 'must returns the sum of daily rate, car insurance and third party insurance' do
      car_rental = build(:car_rental, daily_rate: 20, car_insurance: 100,
                         third_party_insurance: 102)
      result = car_rental.daily_rate_total
      expect(result).to eq 222
    end
  end
end
