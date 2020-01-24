class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  belongs_to :user
  has_one :car_rental

  validate :start_date_cannot_be_in_the_past
  validate :start_date_cannot_be_greater_than_end_date
  validate :must_have_avaliable_cars
  validates :start_date, presence: {message: 'não pode ficar vazio'}
  validates :end_date, presence: {message: 'não pode ficar vazio'}

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.current 
      errors.add(:start_date, 'não pode estar no passado')
    end
  end

  def start_date_cannot_be_greater_than_end_date
    if start_date.present? && end_date.present? && start_date > end_date 
      errors.add(:start_date, 'não pode ser maior que a data final')
    end
  end

  def car_statuses
    if Date.current >= start_date && Date.current <= end_date
      car_rental.car.status= 'unavaliable' if car_rental.present?
    else
      car_rental.car.status= 'avaliable'
    end
  end

  def must_have_avaliable_cars
    return if cars_avaliable?

    errors.add(:base, 'Não existem carros disponíveis desta categoria')
  end
  def cars_avaliable?
    scheduled_rentals = Rental.where(car_category: car_category)
                              .where(start_date: start_date..end_date)
                              .or(Rental.where(car_category: car_category)
                                        .where(end_date: start_date..end_date))
    
    avaliable_cars = Car.where(status: 'avaliable')
               .joins(:car_model)
               .where(car_models: {car_category: car_category})
    scheduled_rentals.count <= avaliable_cars.count
  end

end