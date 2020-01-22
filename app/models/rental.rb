class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  belongs_to :user
  has_one :car_rental
  
  validate :start_date_cannot_be_in_the_past
  validate :start_date_cannot_be_greater_than_end_date
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

end