class Api::V1::CarModelsController < Api::V1::ApiController
  def destroy
    @car_model = CarModel.find(params[:id])

    render json: '', status: :ok if @car_model.destroy

  end
end