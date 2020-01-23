class Api::V1::CarsController < Api::V1::ApiController
  def index
    return render json: @cars.as_json(except: [:create_at, :update_at]), 
      status: :ok if @cars = Car.all
    
  end
  def show
    @car = Car.find(params[:id])
    render json: @car, status: :ok
  end
  def create
    @car = Car.create!(car_params)
    render json: @car, status: :ok
  end
  def update
    @car = Car.find(params[:id])
    @car.status = 5
    render json: @car, status: :ok if @car.update!(car_params)
  end
  private

  def car_params
    params.permit(:license_plate, :color, :mileage, :car_model_id)
  end
end