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
                      start_date: 1.day.from_now,
                      end_date: Date.current)
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

    describe '#car_statuses' do
      it 'should change car status to unavaliable' do
        user = create(:user)
        client = create(:client)
        manufacturer = create(:manufacturer)
        car_category = create(:car_category)
        car_model = create(:car_model,
                           manufacturer: manufacturer,
                           car_category: car_category)
        car = create(:car, car_model: car_model)
        rental = create(:rental,
                        client: client,
                        car_category: car_category,
                        user: user)
        create(:car_rental, car: car, rental: rental)

        result = rental.car_statuses

        expect(result).to eq 'unavaliable'
      end
      it 'should change car status to avaliable' do
        car_category = create(:car_category)
        car_model = create(:car_model, car_category: car_category)
        car = create(:car, car_model: car_model, status: 0)
        rental = build(:rental,
                       start_date: 2.days.ago,
                       end_date: 1.day.ago,
                       car_category: car_category)
        rental.save(validate: false)
        create(:car_rental, car: car, rental: rental)

        result = rental.car_statuses

        expect(result).to eq 'avaliable'
      end

      it 'should change car status to avaliable and then unavaliable' do
        car_category = create(:car_category)
        car_model = create(:car_model, car_category: car_category)
        car = create(:car, car_model: car_model)
        rental = build(:rental,
                       start_date: 2.days.ago,
                       end_date: 1.day.ago,
                       car_category: car_category)
        rental.save(validate: false)
        create(:car_rental, car: car, rental: rental)
        newer_rental = build(:rental,
                             start_date: Date.current,
                             end_date: Date.current,
                             car_category: car_category)
        create(:car_rental, car: car, rental: newer_rental)

        result = newer_rental.car_statuses

        expect(result).to eq 'unavaliable'
      end

      it 'should car status to be avaliable until start date' do
        car_category = create(:car_category)
        car_model = create(:car_model, car_category: car_category)
        car = create(:car, car_model: car_model, status: 0)
        rental = build(:rental,
                       start_date: 1.day.from_now,
                       end_date: 2.days.from_now,
                       car_category: car_category)
        rental.save(validate: false)
        create(:car_rental, car: car, rental: rental)

        result = rental.car_statuses

        expect(result).to eq 'avaliable'
      end
    end
  end
end
