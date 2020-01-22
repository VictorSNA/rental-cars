class Api::V1::CarsController < Api::V1::ApiController
  def show
    if @car = Car.find_by(params[:id])
      render json: @car, status: :ok
    else
      head 404
    end
  end
end