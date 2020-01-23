class Api::V1::CarsController < Api::V1::ApiController
  def index
    return render json: @cars.as_json(except: [:create_at, :update_at]), 
      status: :ok if @cars = Car.all
    
  end
  def show
    return render json: @car, status: :ok if @car = Car.find_by(params[:id])

    head 404
  end
  def create
    @car = Car.new(car_params)
    return render json: @car, status: :ok if @car.save

    head 412
  end

  private

  def car_params
    params.permit(:license_plate, :color, :mileage, :car_model_id)
  end
end