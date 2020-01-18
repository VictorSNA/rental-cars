class CarsController < ApplicationController
  def index
  end
  def new
    @car = Car.new
    @car_models = CarModel.all
  end
  def show
    @car = Car.find(params[:id])
  end
  def create
    @car = Car.new(car_params)
    return redirect_to @car, notice: 'Carro registrado com sucesso' if @car.save
    @car_models = CarModel.all
    render :new
  end

  private

  def car_params
    params.require(:car).permit(:license_plate, :color, :car_model_id, :mileage)
  end
end