require 'rails_helper'

describe Rental do

  describe '#start_date_cannot_be_in_the_past' do
    it 'should prevent start date in the past' do
      rental = Rental.create(start_date: 1.day.ago)
      rental.valid?

      expect(rental.errors.full_messages).to include('Start date não pode estar no passado')
    end
  end

  describe '#start_date_cannot_be_greater_than_end_date' do
    it 'should prevent start date to be greater than end date' do
      rental = Rental.create(start_date: 1.day.from_now, end_date: Date.current)
      rental.valid?

      expect(rental.errors.full_messages).to include('Start date não pode ser maior que a data final')
    end
  end

  describe '#fields_cannot_be_blank' do
    it 'should prevent start date to be blank' do
      rental = Rental.create(start_date: nil)
      rental.valid?

      expect(rental.errors.full_messages).to include('Start date não pode ficar vazio')
    end

    it 'should prevent end date to be blank' do
      rental = Rental.create(end_date: nil)
      rental.valid?

      expect(rental.errors.full_messages).to include('End date não pode ficar vazio')
    end

    it 'should prevent start date and end date to be blank' do
      rental = Rental.create(start_date: nil, end_date: nil)
      rental.valid?

      expect(rental.errors.full_messages).to include('Start date não pode ficar vazio')
      expect(rental.errors.full_messages).to include('End date não pode ficar vazio')
    end

    describe '#car_statuses' do
      it 'should change car status to unavaliable' do
      user = User.create!(email: 'teste@teste.com', password: '123456')
      client = Client.create!(name: 'Fulano da Silva', cpf: '127.587.748-60',
                              email: 'fulanodasilva@teste.com')
      manufacturer = Manufacturer.create!(name: 'Renault')
      car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54, car_insurance: 28,
                                         third_party_insurance: 10)
      car_model = CarModel.create!(name: 'Kwid', year: '2020', manufacturer: manufacturer,
                                   motorization: '1.0', car_category: car_category,
                                   fuel_type: 'Flex')
      car = Car.create!(license_plate: 'ABC1234', color: 'Branco', car_model: car_model,
                        mileage: 10000)
      rental = Rental.create!(code: '1212', start_date: Date.current, end_date: Date.current,
                              client: client, car_category: car_category, user: user)
      CarRental.create(car: car, rental: rental, daily_rate: 30, start_mileage: 20,
                       car_insurance: 30, third_party_insurance: 300)
      
      result = rental.car_statuses

      expect(result).to eq 'unavaliable'
  
      end
      it 'should change car status to avaliable' do
        user = User.create!(email: 'teste@teste.com', password: '123456')
        client = Client.create!(name: 'Fulano da Silva', cpf: '127.587.748-60',
                                email: 'fulanodasilva@teste.com')
        manufacturer = Manufacturer.create!(name: 'Renault')
        car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54, car_insurance: 28,
                                           third_party_insurance: 10)
        car_model = CarModel.create!(name: 'Kwid', year: '2020', manufacturer: manufacturer,
                                     motorization: '1.0', car_category: car_category,
                                     fuel_type: 'Flex')
        car = Car.create!(license_plate: 'ABC1234', color: 'Branco', car_model: car_model,
                          mileage: 10000)
        rental = Rental.new(code: '1212', start_date: 2.day.ago, end_date: 1.day.ago,
                                client: client, car_category: car_category, user: user)
        rental.save(validate: false)
        CarRental.create(car: car, rental: rental, daily_rate: 30, start_mileage: 20,
                         car_insurance: 30, third_party_insurance: 300)
        
        result = rental.car_statuses
        
        expect(result).to eq 'avaliable'
      end

      it 'should change car status to avaliable and then unavaliable' do
        user = User.create!(email: 'teste@teste.com', password: '123456')
        client = Client.create!(name: 'Fulano da Silva', cpf: '127.587.748-60',
                                email: 'fulanodasilva@teste.com')
        manufacturer = Manufacturer.create!(name: 'Renault')
        car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54, car_insurance: 28,
                                           third_party_insurance: 10)
        car_model = CarModel.create!(name: 'Kwid', year: '2020', manufacturer: manufacturer,
                                     motorization: '1.0', car_category: car_category,
                                     fuel_type: 'Flex')
        car = Car.create!(license_plate: 'ABC1234', color: 'Branco', car_model: car_model,
                          mileage: 10000)
        rental = Rental.new(code: '1212', start_date: 2.day.ago, end_date: 1.day.ago,
                                client: client, car_category: car_category, user: user)
        rental.save(validate: false)
        CarRental.create(car: car, rental: rental, daily_rate: 30, start_mileage: 20,
                         car_insurance: 30, third_party_insurance: 300)
        newer_rental = Rental.new(code: '1212', start_date: Date.current, end_date: Date.current,
          client: client, car_category: car_category, user: user)
        CarRental.create(car: car, rental: newer_rental, daily_rate: 30, start_mileage: 20,
            car_insurance: 30, third_party_insurance: 300)

        result = newer_rental.car_statuses

        expect(result).to eq 'unavaliable'
      end

      it 'should car status to be avaliable until start date' do
        user = User.create!(email: 'teste@teste.com', password: '123456')
        client = Client.create!(name: 'Fulano da Silva', cpf: '127.587.748-60',
                                email: 'fulanodasilva@teste.com')
        manufacturer = Manufacturer.create!(name: 'Renault')
        car_category = CarCategory.create!(name: 'AM', daily_rate: 46.54, car_insurance: 28,
                                           third_party_insurance: 10)
        car_model = CarModel.create!(name: 'Kwid', year: '2020', manufacturer: manufacturer,
                                     motorization: '1.0', car_category: car_category,
                                     fuel_type: 'Flex')
        car = Car.create!(license_plate: 'ABC1234', color: 'Branco', car_model: car_model,
                          mileage: 10000)
        rental = Rental.new(code: '1212', start_date: 1.day.from_now, end_date: 2.days.from_now,
                                client: client, car_category: car_category, user: user)
        rental.save(validate: false)
        CarRental.create(car: car, rental: rental, daily_rate: 30, start_mileage: 20,
                         car_insurance: 30, third_party_insurance: 300)

        result = rental.car_statuses

        expect(result).to eq 'avaliable'
      end
    end
  end
end
