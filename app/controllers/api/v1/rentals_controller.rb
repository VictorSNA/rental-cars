class Api::V1::RentalsController < Api::V1::ApiController
  def create
    @rental = Rental.new(rental_params)

    return render json: @rental, status: :ok if @rental.save

    head 500 if @rental.errors.full_messages.include?('Não existem carros '\
      'disponíveis desta categoria')
  end

  private

  def rental_params
    params.permit(:start_date, :end_date, :client_id, :car_category_id,
      :user_id, :subsidiary_id)
  end
end
