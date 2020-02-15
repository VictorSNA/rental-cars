class Rental < ApplicationRecord
  enum status: { in_progress: 0, active: 5, canceled: 8, expired: 10 }
  belongs_to :client
  belongs_to :car_category
  belongs_to :user
  has_one :car_rental, dependent: :destroy
  has_many :accessory_rentals, dependent: :destroy
  has_many :accessories, through: :accessory_rentals

  validates :start_date, :end_date, presence: true
  validate :start_date_cannot_be_in_the_past
  validate :start_date_cannot_be_greater_than_end_date
  validate :must_have_avaliable_cars

  def start_date_cannot_be_in_the_past
    return errors.add(:start_date, 'não pode estar no passado')\
      if start_date.present? && start_date < Date.current
  end

  def start_date_cannot_be_greater_than_end_date
    return errors.add(:start_date, 'não pode ser maior que a data final')\
      if start_date.present? && end_date.present? && start_date > end_date
  end

  def must_have_avaliable_cars
    return if cars_avaliable?

    errors.add(:base, 'Não existem carros disponíveis desta categoria')
  end

  def cars_avaliable?
    return unless start_date.present? && end_date.present?

    scheduled_rentals = Rental.where(car_category: car_category)
                              .where(status: 'in_progress')
    avaliable_cars = Car.where(car_model: car_category.car_models)
                        .where(status: 'avaliable')
    return false if scheduled_rentals.count.zero? && avaliable_cars.count.zero?

    avaliable_cars.count >= scheduled_rentals.count
  end

  def verify_cancelement(description)
    if description.empty?
      errors.add(:start_date, 'deve ser preenchida')
      false
    elsif ((Date.current - start_date.to_date) * 24).to_i > 24
      errors.add(:start_date, 'já ultrapassou 24 horas')
      false
    else
      true
    end
  end

  def return_accessories
    @accessories = accessories

    @accessories
  end
  # def rental_is_expired?
  #   actived_rentals = Rental.where(car_category: car_category)
  #                             .where(status: 'active')
  #   actived_rentals.each do |actived_rental|
  #     if actived_rental.end_date < Date.current
  #       actived_rental.expired!
  #       actived_rental.car.status_avaliable!
  #     end
  #   end
  # end
end
