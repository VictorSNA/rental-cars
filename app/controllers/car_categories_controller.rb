class CarCategoriesController < ApplicationController
  before_action :authenticate_user!, only: %i[index show new edit]
  before_action :set_car_category, only: %i[show edit update destroy]
  def index
    @car_categories = CarCategory.all
  end

  def show
  end

  def new
    @car_category = CarCategory.new
  end

  def create
    @car_category = CarCategory.new(car_category_params)
    return redirect_to @car_category,
      notice: 'Categoria de carro registrada com sucesso' if @car_category.save

    render :new
  end

  def edit
  end

  def update
    return redirect_to @car_category, notice: 'Editado com sucesso'\
      if @car_category.update(car_category_params)
  end

  def destroy
    return redirect_to car_categories_path,
      notice: 'Excluído com sucesso' if @car_category.destroy
  end

  private

  def set_car_category
    @car_category = CarCategory.find(params[:id])
  end

  def car_category_params
    params.require(:car_category).permit(:name,:daily_rate,:car_insurance,:third_party_insurance)
  end
end
