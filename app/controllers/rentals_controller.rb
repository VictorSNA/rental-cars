class RentalsController < ApplicationController
  before_action :authenticate_user!, only: %i[index search new]
  before_action :set_rental, only: %i[show begin confirm_begin cancel
                                      confirm_cancel]
  def index
  end

  def show
  end

  def new
    @rental = Rental.new
    @clients = Client.all
    @car_category = CarCategory.all
    @accessories = Accessory.all
  end

  def create
    @rental = current_user.rentals.new(rental_params)
    @rental.code = SecureRandom.hex(6).upcase
    @rental.subsidiary = current_user.subsidiary
    create_accessory(@rental) if !params[:accessory_id].nil?
    return redirect_to @rental,
           notice: 'Locação agendada com sucesso' if @rental.save

    @accessories = Accessory.all
    @clients = Client.all
    @car_category = CarCategory.all
    render :new
  end

  def search
    @rentals = Rental.where('code LIKE ?', "%#{params[:q].upcase}%")
                     .where(subsidiary: current_user.subsidiary)
    if @rentals.blank?
      flash[:notice] = 'Nenhuma locação encontrada'
    end
  end

  def begin
    @cars = Car.where(car_model: @rental.car_category.car_models)
               .where(status: 0)
  end

  def confirm_begin
    return redirect_to @rental, notice: 'Locação já iniciada' if @rental.active?

    @car = Car.find(params[:car_id])
    @rental.active!
    @car_rental = CarRental.new(
      daily_rate: @car.car_model.car_category.daily_rate,
      car_insurance: @car.car_model.car_category.car_insurance,
      third_party_insurance: @car.car_model.car_category.third_party_insurance,
      start_mileage: @car.mileage, rental: @rental, car: @car
    )
    return @car.status_unavaliable! if @car_rental.save

    @rental.in_progress!
  end

  def cancel
    return redirect_to root_path, alert: 'Você não pode fazer essa ação' \
      unless current_user.subsidiary = @rental.subsidiary || current_user.admin?
  end

  def confirm_cancel
    return redirect_to @rental, alert: @rental.errors.full_messages.each\
      { |message| message }\
      unless @rental.verify_cancelement(params[:description])

    @car = Car.find(params[:id])
    @car_rental = CarRental.find(params[:id])
    @rental.canceled!
    @car.status_avaliable!
    @rental_cancellation = RentalCancellation.new(
      user: current_user, rental: @rental, description: params[:description],
      car_rental: @car_rental, date: Date.current
    )
    return redirect_to rentals_path, notice: 'Locação cancelada com sucesso' \
      if @rental_cancellation.save!
  end

  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :client_id,
                                   :car_category_id)
  end

  def set_rental
    @rental = Rental.find(params[:id])
  end

  def create_accessory(rental)
    @accessories = Accessory.all
    return if @accessories.empty?

    @accessory = Accessory.find(params[:accessory_id])
    AccessoryRental.create!(accessory: @accessory, rental: rental)
  end
end
