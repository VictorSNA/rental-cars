class RentalsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :search, :new]
  before_action :set_rental, only: [:show, :begin, :confirm_begin]
  def index
  end
  def show
  end
  def new
    @rental = Rental.new
    @clients = Client.all
    @car_category = CarCategory.all
  end
  def create
    @rental = current_user.rentals.new(rental_params)
    @rental.code = SecureRandom.hex(6).upcase
    return redirect_to @rental, notice: 'Locação agendada com sucesso' if @rental.save

    @clients = Client.all
    @car_category = CarCategory.all
    render :new
  end
  def search
    @rentals = Rental.where('code LIKE ?', "%#{params[:q].upcase}%")
  end
  def begin
    @cars = Car.where(car_model: @rental.car_category.car_models)
               .where(status: 0)
  end
  def confirm_begin
    @car = Car.find(params[:id])
    @car_rental = CarRental.create!(daily_rate: @car.car_model.car_category.daily_rate,
                      car_insurance: @car.car_model.car_category.car_insurance,
                      third_party_insurance: @car.car_model.car_category.third_party_insurance,
                      start_mileage: @car.mileage, rental: @rental, car: @car)
  end
  
  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, 
                                   :client_id, :car_category_id)
  end
  def set_rental
    @rental = Rental.find(params[:id])
  end
end