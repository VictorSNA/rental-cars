class Api::V1::CarsController < Api::V1::ApiController
  def index
    return render json: @cars.as_json(except: [:create_at, :update_at]), 
      status: :ok if @cars = Car.all
    
  end
  def show
    return render json: @car, status: :ok if @car = Car.find_by(params[:id])

    head 404
  end
end