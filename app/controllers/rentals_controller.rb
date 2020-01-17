class RentalsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :search, :new]
  def index
  end
  def new
    @rental = Rental.new
    @clients = Client.all
    @car_category = CarCategory.all
  end
  def search
    @rentals = Rental.where('code LIKE ?', "%#{params[:q]}%")
  end
  def create
    @rental = Rental.new(rental_params)
    @rental.code = SecureRandom.hex(6).upcase
    @rental.user = current_user
    return redirect_to @rental, notice: 'Locação agendada com sucesso' if @rental.save
    @clients = Client.all
    @car_category = CarCategory.all
    render :new
  end
  def show
    @rental = Rental.find(params[:id])
  end
  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, 
                                   :client_id, :car_category_id)
  end
end